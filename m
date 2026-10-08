Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56F3DB63F
	for <linux-pwm@vger.kernel.org>; Thu,  8 Oct 2026 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449055; cv=none; b=MJz/LLevvFIP8EyXerh/dKbg57l6klRih0ruCH+HoTv4lz2w9WrERpeV7ijdqj698KgYR4GktvATRSewqAd2pF/cgs53l7qCQtG6MhiKQdGuplvC1gpFUA5SIyDD7+bsB8unRiceTRMadtV17quUOHjxkABbb21ldsq90k6e+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449055; c=relaxed/simple;
	bh=8XRz2m7ODag9sGecW0L756bQlx33AeahS9N5ej7iIXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oZBRf/qWbpNmFCoB9b168r6ZOFN3OWzozifOch0RaIMwjL14DwOS4Io72Nm2u/Pj7dOB26R5D+F2rPCHSf8zbF60HqiJ7hunQE3yjlxascG/F6sah/S2TtZsFZtS4hf3xslxBBzk9ku6UVXXPocJ7eI9yBwfb7o2/MT15sexjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oZmwFFOJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VinwhakY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oZmwFFOJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VinwhakY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987KcmN2686635
	for <linux-pwm@vger.kernel.org>; Thu, 8 Oct 2026 08:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qvQ92t2jkdC6exdh59r8e9
	i0QzBBAbnteMfEjRvpDbw=; b=oZmwFFOJM1c+fms2e2GOgneru1/GrgG2FTBbzV
	laqmu/MLc8pqzfWBEuQ3hEKNV1m32RvNV6mGLcLs5Mnaz8kJdKr9S2Liz5IVyg1Z
	uvqRmCwiI6Uud0tQGgQW7BxCw3qX2PNYgTU4VJcJDNIL7SQYJHP+z95bxusAYBsw
	9VB7pj7BSZ9/cJ8uOcYa6M/G74WC6jCQDyYLJ8xe6jTP44G4hOMSFdfZhBzc2Prd
	WDyR/9sHxA2SMoSwNFto34nAwPo1Eb8zPkWp4wsfJ3BqHWQ74s/z2T7bJyhKRASq
	AgeWOKpT4YzWRIftk9/5gIO0NBzRyOTwlSfyyBKZThm3sndA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe420hd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Thu, 08 Oct 2026 08:44:12 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-152d1363a29so9196081c88.1
        for <linux-pwm@vger.kernel.org>; Thu, 08 Oct 2026 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791449051; x=1792053851; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qvQ92t2jkdC6exdh59r8e9i0QzBBAbnteMfEjRvpDbw=;
        b=VinwhakYPXCgGhruwmQv2zOCoG9xPKUO1X1u6Y2fOmk8eTdaI6lbZoRYUensprXZ+K
         lXFqN+6lXzv6Acn4MhGLssNGI5sDvYMqVBm3x5ZJDNggFNy1q79M60JE5P0MZnmHDi8+
         SNAQiuY71q+hFRV76hxzlH8qFDGOjlh1kSZ6eZcAjM4EYbEPH4wSnpllOYJPUFU8uYkO
         AbjXJxnndeakSkbWPCQEgrCQI8w6bqFaqJZw1I09K0OJHqXT4N2niAOs1MIun976Hg9x
         830YCnJ+gc91EOwL9M2kWT8grNvfFLd5tcRcYA2yXZ3nWwDxVVVFiV3/1H5eg+hPqq8r
         5czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791449051; x=1792053851;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qvQ92t2jkdC6exdh59r8e9i0QzBBAbnteMfEjRvpDbw=;
        b=QeMBgN1lvayKZ/pSBb7lNG9JAs1+I87+jXHBxDI/olafNoumZuKbdv73Qn+RDafA7C
         NMif7gWUIT0gfdVaqkhhU1VboHVGL0zq0oQGfJT3mGbv3kzJtPKuyhJsH5TQPQPKgn7t
         AOcCPCiBBdS40JPMst6SdfkjQx7zK2PWyGKl7CcnIa0FyVQlloXN3i9qv5Tt/aISNKLq
         fy5aX/NAEA4Kf1b34QDuPjJSmI315fplTlO79uYcsUfqKg3WHWgYpJsJ6IN8zb53opVa
         giOoauD4kuHPSEV+3Uoz1qvONQRvLkcIiMdl3VflxmH5V5bbFsj9mkxfgmyJPlK4zbFr
         J9Ng==
X-Forwarded-Encrypted: i=1; AKwUvBx00rHgggUp2MzGONTu/H4e9vFEGo1nw1BD37ylE9O6chI0c7txUdLuAiaPGjYVFOWRpVUrrtaAZBQ=@vger.kernel.org
X-Gm-Message-State: AFuF++klL3aE8QXR2A/JUTpR2a4lIloVjT+DXc1sOY9hWYTn5Z4cpLqz
	LsKrlEgyv7dJmmazyNfh8lNCwPkcn6oUe7tEuGYYYtPviKkLmsZQCVCkLhc0ucYVRh9v3cZ+Ta8
	y4HOm5Op1zr7YTrXZokSfhsycoSXlUw1gDNmPdLt5S413OKr8PhGcVjBN74vYSI8=
X-Gm-Gg: AYBFou3hyA1u6I4cvSpcyFxtwcn26ws1ztWNl85+PvLklB50QFnI6WLRf+ObPsE8BDs
	x2IIYM/nxCM7i3Urfma9dK/WqyebOvOle3lg6sIaREO+TpmEVFZWb0MmPoXzKSf57NWQ4W93Cr7
	e6JpxcPU2gla5251nuWTJWmre65+wg+V60TphbFVsfTp0AKV7kAuAjF/kNj5CgYJ9QvS3X32Q/s
	w2ObW6/spPN5ZPFKP38nNGQbpPcaBFtLP7YaRt4h//wZ1fShmdwYYSMCxM7Cl8vbxhtLdClINHb
	vXfjikgrLZ5RQWbl/qgQ5eWC4GdINE0ZmRu4F1ncBDgciIyqDQJ+xAsaZI/EXrVDBbH98gp6MYF
	SWm4XNCPJG79rlxfxDcJU+9EHeUTbld5zBATXcRoUmQSval9C3Ryt/oZ//sRXn2zYw+0p/qshUK
	c45UzTXlMhpjlkNeX7Gdj047kv4DHYfA==
X-Received: by 2002:a05:701b:454a:20b0:145:f4:13ff with SMTP id a92af1059eb24-16209f0a817mr5723176c88.43.1791449051310;
        Thu, 08 Oct 2026 01:44:11 -0700 (PDT)
X-Received: by 2002:a05:701b:454a:20b0:145:f4:13ff with SMTP id a92af1059eb24-16209f0a817mr5723153c88.43.1791449050659;
        Thu, 08 Oct 2026 01:44:10 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm5216348eec.30.2026.10.08.01.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:44:10 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 14:14:00 +0530
Subject: [PATCH] dt-bindings: pwm: add IPQ5210 binding
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pwm-v1-1-0b8776398632@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM9Xx2oC/zXMQQ6DIBCF4auQWTsJWNOqVzEuBMY6C1CBtibGu
 0tqXP4vL98OkQJThFbsEOjLkWefQxUCzDT4NyHb3FDK8qmkfOHyc2is1bV+qErZBvJzCTTy9le
 6/upA6ydj6RpBD5HQzM5xaoWnLeENQn8cJ9Yz5JCGAAAA
X-Change-ID: 20261007-pwm-cddb8b3141d9
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: UslQ5MxFtFGNF16yG8sHI2aQMiY7Cs-_
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac757dc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=YhYfuao1U0lJTJAE8lkA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNCBTYWx0ZWRfX3Ij7sHlb5cqY
 g/vHvjiP/hJNWmjU15SJ5z1ySkpj701JEVk6uYItJ9ISqOesqit33pmCvldnWzOQ9n/9h3JeU7G
 LDBff5OsactETRvUMUoGdAUEG9z2EzQ=
X-Proofpoint-ORIG-GUID: UslQ5MxFtFGNF16yG8sHI2aQMiY7Cs-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNCBTYWx0ZWRfX/aBBUt1BAnNK
 ZseSWpAjtWoBfjn/RlFcpbLG4BpI3IpDO/YXL4wWTXwfHEvrNb9iM+ukweSilLDE1EaJ+gOGR9o
 J4SfYGbTNVzI985hyzjd2j20j+JA/XXcAOLZ31tg6rSEUcjMNxBNVhqcLwlqS3Si4N2uMC6q/uP
 AWWTDAh9NITUuat8zDS79mzDviK9v34ZWFamcWBbIb1epEbwBSVb8KEWfabhYbq7Ook2Q7idkZS
 nXLx1XJpo0AQPXV6+bOV7cuTDOeL0DJy4qNvGAmzVr2Id6I/jI4lhiWFr+5cuqiMy74BnO7m5Kn
 zKM8OYu03Xwl2HAwCI+YoHaA3U/EOUbv/HnAU5j5MfzwTSFwk2iW+yVOuVKxqsOm0T3bXhzhXSP
 P89M/9z+HYTKepJK7wjcQS+PkbzppkzAmt1F3VyibE/Ln1qIS3yBIFQT1qxhr+CvWiUjYljeWjd
 5wjY8/pABQrE0Vl8zjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080034

Add DT binding for the PWM block in Qualcomm IPQ5210 SoC with
qcom,ipq6018-pwm as the fallback.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
index f9f1f652e752..c6b9004dd30e 100644
--- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-pwm
+              - qcom,ipq5210-pwm
               - qcom,ipq5332-pwm
               - qcom,ipq9574-pwm
           - const: qcom,ipq6018-pwm

---
base-commit: cf4a8255a424f691f95dfa378e88336f33aa8ae4
change-id: 20261007-pwm-cddb8b3141d9

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

