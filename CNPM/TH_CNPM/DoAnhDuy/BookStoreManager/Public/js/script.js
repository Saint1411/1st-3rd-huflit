function ChangeImage(UploadImage, previewImg) {
    if (UploadImage.files && UploadImage.files[0]) {
        var render = new FileReader();
        render.onload = function (e) {
            $(previewImg).attr('src', e.target.result);
        }
        render.readAsDataURL(UploadImage.files[0]);
    }
}