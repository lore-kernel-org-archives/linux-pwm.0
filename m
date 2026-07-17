Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE23A16AE
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784322003; cv=none; b=R98LK/Is3r8fwV5EUONLzupd1kDLZGLpsyYxmQgZOrJjhLLPxi92q+gQ71BSxFFqj++fabhwh284oK7d+ghfZ8Mz88ojmVgj5s0cXPwe7HsGsDkfnCsi/7hwGVfdA1lJl04WEyyMGQIUoDm1/lvU/oUDviuvUc9zI0p+wB2Hv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784322003; c=relaxed/simple;
	bh=8Fve2063ng9ha5wZtD1FR+vdZcWSIu8cW4ZgNpjdBwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmkpsKP3rkUDxAeWQ+uWgBV2LsZ7aOkj4l5sV37EN4oJr8iRtavh3ZBBF+UZv6Ddm8krTjGI4mV/+n7DriHbtLUOfymiZzezB023FFvDKWpTKapuQac5vEmEHS+zswApWR2aQt6+GdnDzBjN/pqwfJz5U0mMwhR7NEiAef0pip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOzuxz/S; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOzuxz/S"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e9f7491ffso104650687b3.0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784322001; x=1784926801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FetDMiCgPkyxkRzwngK3OSAJNfZgDIIZiTYVMWGBG8I=;
        b=SOzuxz/SPFR6TLAAXwUIM6M971JUOobWorPE/Bxo2kwum8Ro0dBuy945l/pZy55KVe
         1iJ84shaDHpsIMeyqAm8sdV0lhrYDCE0JEuLbBnzfwv4HUFX30CV3YTUXCfzH6kLnv2E
         1Kwts0XjYrPjUsSZdCXM/gSxN9wMBLMFoIP0S4LDKfGHb07QzbuTIHDTJrekC74kOpH4
         r58sdMJI4PzEEEKEhvRZny7lkmI6FHwLNneZU6pev6K+6dbsO6iS+OkyJ04uxH7j52xQ
         i7iGwgFMS3MswGjvaMnzeayG5VjOvZ7Y0JnhE6cEzk/fq6UfmPz4XqlmQDeqzL3O0IJ+
         jfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784322001; x=1784926801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FetDMiCgPkyxkRzwngK3OSAJNfZgDIIZiTYVMWGBG8I=;
        b=Flsev6Hvm3QOl9WGzveUPSmkQbxZMwb4foXSh9ylxz7DjFOJGaVw0to/FRUPAKefww
         vvN+jNb4ap5leYYSsOS9Ru11FBiwSV5S2UO2FptTplzrVJWuW39wo51cNq34jpX/NYj/
         79h/vScbQ+UYbQ+UDjEkqbZLJ0HY/JYQfz77MxxqLlKkyqkJrRnWjTJXDTmZGaWhP0qp
         KUlIq0AF5F4rLeds3yeo0IXdP49fHMf/QCE7M+NG+ay/2kKsYSCpDZz8Bo5u71CDkeOJ
         21kiWklYfvieK/rhMJ/kfF+VeFjVSAARE1p00Foj+Cghuf9ypjduWvl/5ciUXCXnHs7C
         Lyyg==
X-Forwarded-Encrypted: i=1; AHgh+RrrjlMRz1998Mkey8lON+Qk4Tp1qOez0fzOZcwFrd3YLQ4oFlysrQAC2jboWnjRXdndUh7Ong/kuJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi2IrYVtMyJibCp9wAN/eDyGNemvhObmXAV3xIyjM4a7vYPO1
	GowE7fr/UHzcQtpUW7E2hcgxdJoxii3C9aUdSFXbZve4RAO/oz0FO0pujD1Jbg18
X-Gm-Gg: AfdE7clg1pEbsy/pyKWL4yPnfKPsZ2YkUH561tK2GjDosCPT2VGG4pcg2kswt9AsoHD
	dcq922wBJ82hglj/mi+4c6yd8efPtrSDpd/yEEQI9Khnz6leMSbWufT+a3KF6X+/SefTy9rR5aL
	3A6jXJpnvf7/mNvrRLt7C4vLwF6FrKrVcWf+hVlWY5CVIM+czWFsanFXkvRhgWwtvfzdMrxZXkK
	GFBW1jvbcq5BrOdlkeW9WVwT57Tohk0492Gb0Gcio+9DFN9RoK3qCRSYI8z58Q17yAdimV1oBSx
	swuRicbT7cjTOiIXgWAEj0ZpmQOhUNXrCw6ZKhmRB66h33NqJfMIYpMpUkmOy1A4cUN3QVRWykh
	xOWnqMkPUBAp5zG6V3Xp2MpsfNc4uDQSJ3S/s4oev6dc908D1ZegNDK2OtYZeI5cd6hd9Hty0Oa
	jHt6EWbaib4dB0rlzI
X-Received: by 2002:a05:690c:650f:b0:81d:42e6:6a82 with SMTP id 00721157ae682-81ef273585emr18799947b3.25.1784322000847;
        Fri, 17 Jul 2026 14:00:00 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef3e6656dsm20013647b3.0.2026.07.17.13.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 14:00:00 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 17 Jul 2026 17:59:19 -0300
Subject: [PATCH v2 6/6] hwmon: (adt7470) Add thermal zone sensor support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-adt7470_thermalzone-v2-6-a55147958fad@gmail.com>
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
In-Reply-To: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Darrick J. Wong" <djwong@us.ibm.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2

Expose the ADT7470 external temperature sensors to the thermal
framework using HWMON_C_REGISTER_TZ.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/adt7470.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index aaae14a421cd..595a8f934d60 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -1251,6 +1251,8 @@ static const struct hwmon_ops adt7470_hwmon_ops = {
 };
 
 static const struct hwmon_channel_info * const adt7470_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,

-- 
2.55.0

