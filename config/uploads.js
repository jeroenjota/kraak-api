import path from "path";

export const uploadConfig = {
  basePath: process.env.UPLOAD_BASE_PATH,
  pdfPath: process.env.UPLOAD_PDF_PATH || "pdfs",
  tmpPath: process.env.UPLOAD_TMP_PATH || "tmp",
  imgPath: process.env.UPLOAD_IMG_PATH || "images",
  maxSizeMb: parseInt(process.env.UPLOAD_MAX_SIZE_MB, 10) || 50,
  publicUrl: process.env.PUBLIC_UPLOAD_URL
};

export function getBaseUploadPath() {
  return uploadConfig.basePath;
}

export function getPdfDiskPath(filename) {
  if (filename) {
  return path.join(
    uploadConfig.basePath,
    uploadConfig.pdfPath,
    filename)
  } else {
    return path.join(
      uploadConfig.basePath,
      uploadConfig.pdfPath
    );  
  };
}

export function getTmpDiskPath(filename) {
  return path.join(
    uploadConfig.basePath,
    uploadConfig.tmpPath,
    filename
  );
}

export function getImgDiskPath(filename) {
  return path.join(
    uploadConfig.basePath,
    uploadConfig.imgPath,
    filename
  );
} 

export function getPdfPublicUrl(filename) {
  return `${uploadConfig.publicUrl}/${uploadConfig.pdfPath}/${filename}`;
}