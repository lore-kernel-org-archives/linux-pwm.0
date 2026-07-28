Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E930FC1F
	for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2026 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208066; cv=none; b=Jk6COYNUMP3fzmzpT4OIsPpjjDo0Ix1tQxchzRd4FaUqfjIeRbcX9qGrmkAXK8XFvCNjF0IikS2WwxFBG5QQgYzkC61Ijn4GbdwIaJQ/f6OQrnefEBHxnATZzD26MU18D1uxtAJxzRT6b6SKVaDk6c/7NL/2Q/tizlLNty+1ZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208066; c=relaxed/simple;
	bh=BX7QAOofmDbVSjrT426QK7z8VWDtDhzJkXrvBic/mw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpmxC8Y6pB6EEKCajocaKWbk9Rf4gQV/hug7ekKdoGURR1h4dzfBVElRNNw6CSa/ks6PXG434ip1zdCCOK/EKVEjtBfDFLOINXqr7t90eyt9H8w1OMWlQr6v1ptLVEp+3TESjvKZu1k4hKu342OQRvBv1BsYH9Ak7qlwSOjJohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPjuaqqF; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPjuaqqF"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so2067902e0c.2
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2026 20:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208064; x=1785812864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hoekbLvx48+rjORuZnTpjcNVtRnI+7NWPDch8cj21zo=;
        b=PPjuaqqFWpHGsEnHD39oUYxr5Z/mQ/LfDV7febgWHuCluUpM3+c2p6waWd1oTZNHme
         kHNXzH4+ApgIylwTPOcyjP8asuebiKdq6MdBBxJO77sK3Pbj04yMmqgJdhfG5MsjeS6X
         dfuI1ryPbr3VC2tS8UFNxVOI5PZlNWnr3K6vKHJ+ajCXEhrA4TOJDk5cSaPQruoa1y8i
         G8TLT23o55kHBFdkEpKvnOMQzEW4csXOPcSg9wYub4ZGC97oFA7i0QioqObWLgN7Qza7
         QdkvyKojuqDtrJrnD/uPzkH1d469Nr5i0q87jVa/oP2G0ZbrVflBZYcWLGNLYMAIjrrj
         QLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208064; x=1785812864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoekbLvx48+rjORuZnTpjcNVtRnI+7NWPDch8cj21zo=;
        b=P0thXysYvWF1ujCycXHxQHu5MzDIjxY40LJVgAVh/yv639se7KOqHwjc3IhCvgCFqa
         ek9lprdk7IZAkVMWZcjndW8AwVvp6Z3v2k2bqlBt3lcxnE/ntN7DfiuavMAP8XbOv8uY
         4kFUkMIUUkNQD8vLcHa9/TOz3PtALELGR/txuKDMIxAKUYdhtze4jXNnjndEFuC/69vg
         m3I2qjX61QY8+C4ggdfRikiBQ62g023HIrqdZUuhzxCZbyjqgDZ/VavADMOcw98xnp8Q
         f0eAq9VhtP8rIfQQ9ObzumHltgWrHegsQ1sgfDfHvZ5bjAUqDCoMsd/gNpZef9sAThFK
         tv+w==
X-Forwarded-Encrypted: i=1; AHgh+RofRJixmswSSqxADRinMKHIajDrP+QLDw6xKddUwtp69AoOTUzKAlIgYbz7gqcs4DrqgZHPLEIFcpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0O2vj419iNRCQWIB7imwLqppNQg4TsVq8qoOcdoHWDX7PURwP
	2Yd+mr7oQksajmpifCwwkfh/lwOOBKJ4c8xyyCOyWL1tqrBRByEKSBAN
X-Gm-Gg: AR+sD13Y/qIsB/753s0IsprCxL71vOujVleRraIrId8a9gvUaejRFfTfJW9dS61Aw8h
	p9eeDovNNBP2qAGhAnHH8BLI8RIviF6dX++9ZnswcPo9w+oXauAZ4zMAPiL8jzwV5cuCat5Y6+8
	6CReGidKo8PXobP99tpmaP0e9Dd5VlVRIEc5Zrpf0a3OywWR0YFxf22ufljm1FeHecMJK5+XJ2o
	NrO14grFa+qlx0/FENd5As9CDlZmx0heFTYghPSn7EPBip+TqQsCn2AwS266ZvxaZKajWVCkxd+
	ovLjppwNKPRVu835Q8oBCxMcAvfkCplgCrXULSuOd7ZOgTmCqsgo0BRuCuMt2FLiIUvefWJf31P
	cwPkRGgwIgudnzb3+O/mt+Ht6tNY8IF0rJQKuTxItoWtoWeeSAHSusJKGEfh53HmrRQlr8FyJkF
	v9dn4baSxbXdM8VYDQVQ==
X-Received: by 2002:a05:6122:30e4:b0:5bf:8807:b154 with SMTP id 71dfb90a1353d-5c33fad04ddmr222788e0c.13.1785208063920;
        Mon, 27 Jul 2026 20:07:43 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c305759d35sm8148812e0c.18.2026.07.27.20.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:07:42 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 28 Jul 2026 00:07:12 -0300
Subject: [hwmon-next PATCH v3 4/4] hwmon: (adt7470) Add thermal zone sensor
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-adt7470_thermalzone-v3-4-d4586478cdba@gmail.com>
References: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
In-Reply-To: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
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

Register the ADT7470 temperature channels as thermal zone sensors.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/adt7470.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 883838fdcd7d..6cc246aa1285 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -1349,6 +1349,8 @@ static const struct hwmon_ops adt7470_hwmon_ops = {
 };
 
 static const struct hwmon_channel_info * const adt7470_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,

-- 
2.55.0

