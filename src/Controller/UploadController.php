<?php

namespace App\Controller;

use App\Services\Picture;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class UploadController extends AbstractController
{

    #[Route('/', name: 'app_profile')]
    public function index(Picture $picture): Response
    {
        return $this->render('profile.html.twig', [
            'upload_route' => 'app_upload',
            'profile_picture' => $picture->getPicture(4),
        ]);
    }

    /**
     * Vérifiez que l'extension du fichier est présente.
     */

    #[Route('/upload', name: 'app_upload', methods: ['POST'])]
    public function example(Request $request, Picture $picture): Response
    {
        $file = $request->files->get('file');

        $allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif'];

        // Get the elements after the first dot
        $extension = substr($file->getClientOriginalName(), strpos($file->getClientOriginalName(), '.'));

        // Check if the file name contains any of the allowed extensions
        $validExtension = false;
        foreach ($allowedExtensions as $allowedExtension) {
            if (stripos($extension, $allowedExtension) !== false) {
                $validExtension = true;
                break;
            }
        }

        if (!$validExtension) {
            $this->addFlash('error', 'Seulement les images sont autorisées(.jpg, .jpeg, .png, .gif)');
            return $this->redirectToRoute('app_profile');
        }

        $file->move($picture->getUploadDir(4), $file->getClientOriginalName());

        $picture->updatePicture(4, $file->getClientOriginalName());

        return $this->redirectToRoute('app_profile');
    }

}
