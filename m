Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD643101A0
	for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208054; cv=none; b=gqMTFKMNemYzcPD7pdcmtzQTBVriyifaLvbmE5S48Z9CUfqaBJ9NVgwYcGBG/vvKYOOPxAEQ/Q/oHtDKgHRf+9qwi+eAB7c87ln0gA0bx7f3g8dqj9GK/TwafwImLspj/H+6nMPo/s74fJ4fsI78/6Jd++pFfnfjfU0PtoCVN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208054; c=relaxed/simple;
	bh=rWZwf1SmZmy+I60NhIjL5+z4C+Nz7YTugxwvI3MpXGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVfyVIM4fEjNf0ofR4WmEmlt676f645fXp5l+RsSo2s59GXq/mJfTjE65iEA5MENzla2RwcJpbJqXudDQxIgGZjjb/TLVtq2vAmlkJITXdnInpkwvvAQysYMCjnmnVHUHPhJ0oeqszh8DXzZqKePZRFZ3KFicxaSHV1n60JUQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSFj5MFh; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSFj5MFh"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bf9466412fso2184854e0c.1
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2026 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208052; x=1785812852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsowAhie0fn+JDFgZmQoMRNcudB/ZaxkZWEVB+SjP1w=;
        b=NSFj5MFhXUC2HyIcXEtaJ8lgvXUzqezQNYRr4yEuJVk5M/4IwVpZT9hGivAKBWEMKB
         JVVEcIUqW+2uAsv9tBQBnUjrVjI9uQxQY4YYEjTsteWRSD9JsuqmhobHWMwsXdhiliQZ
         Ftee0S3jpIFL1dZ4Zxj/+WYiT+1hYTGZLxnIqdXrIRoBjMIrjbqVv/40lQvgtEiIXJ8o
         MYwXB/+dZI0JCSVuMY+KcoWXeTOETpmfjlTSn52tX7HD6t9Wz1W0d+QoC3h45y/EcYj5
         IUViDamIpbUm3veWey/xdhH7g3DwWyYNlpX4c7iSrjEWxaEW7xlFgIfyHyaESXPxzKT6
         PMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208052; x=1785812852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsowAhie0fn+JDFgZmQoMRNcudB/ZaxkZWEVB+SjP1w=;
        b=U532VGuhv6ULtD8qZ+hg2pVHrYghR5GOTN8Xarm795YW0Ua0xGehkff8BZUK2jY0AO
         0pFIN3pgi0PmQkR7d1hhxb6LRXDYrR5cmNDVmicgueivwzQenS0vnTnYaO0GHft2joB/
         Of4IzeLcYbDjrZ1mmMrWbz7MxCc6EJTcBq9Y1LByXVT3n9SQ+BQQVtCwiHiAdZY2L5va
         Jbyz8TiHtjO+tAe1NJ/e2NmEYlDBazbsRpU6EJq6CnEbg+3wKb0juhRkfX61UOVTUyj0
         4El2QSswj/rixOq73j6+PQlSfQoEFgmbBGMyfG5Cy00pLMgG06dRxOUzxB9ZefD1guNp
         ypWA==
X-Forwarded-Encrypted: i=1; AHgh+RoFJ3FANM/8Jc3edJ1Z+TusIwykiD6UrVA9nbH3Vw8fo/FTkfGrq+mEkwBF5OLAnwig9yXe8ltEBSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUrlpdOSx+eIuHespZwaTH+JqQUeDNqUEU2OHhQbOZ/BKHgpZ
	Fnas3ph5w/sZvZhwAIgu8//bywX3GQaFZ92kOYXxTE8MKKu3sMNIDh/1
X-Gm-Gg: AR+sD11eCPA2iV9D2zRV+BZNinMkIVI/Tw7z+bzC6LuRxVKgARHrA7zCVVp8wKkkZqM
	IKKUht6UP6GReXQco4aURo/OwOUjvzyeaBrrHnmyy77kEz4lHAD/pbLRjI8z+URhR7I/2nb06yF
	NSyqCQ4fkv23TWS6MFiisCFgPRKZXtsfy8ybpwCLghV1efHefgZTr+Gi9pwVMx7TfR1lb55EmxY
	nyjnslt1jMnU/fbPpXO3+MLXlfHqj05qFI9UUfkpoDtNX/Ldes81JUkJ2T9OBCyw+itzRfMZFFB
	UNBRZclPa1M1w7P4m8o797AtQnNjpNSZYJUrrQhxAUb+1QS7qCuYcJH/Zpy+9Bo06mC5wUb+WwS
	qDGYQ+2L+ZhUF2WJQOxRbjpHgTUHmNTAVUel+u8tgno3WdnEnfa1F48xjaX41guJqdOZ39BXmUl
	WY+UABKlvshqePBZyo0g==
X-Received: by 2002:a05:6122:328e:b0:5bf:8c77:e89a with SMTP id 71dfb90a1353d-5c33f89b5d8mr301894e0c.2.1785208051755;
        Mon, 27 Jul 2026 20:07:31 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c305759d35sm8148812e0c.18.2026.07.27.20.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:07:30 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 28 Jul 2026 00:07:10 -0300
Subject: [hwmon-next PATCH v3 2/4] hwmon: (adt7470) Add ADT7470_PWM_MAX
 macro
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-adt7470_thermalzone-v3-2-d4586478cdba@gmail.com>
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

Instead of a magic 255, use a macro to refer to it.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/adt7470.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index c45b984c02e6..87ddd7b8ddae 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -100,6 +100,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 #define ADT7470_REG_FAN_MAX(x)	(ADT7470_REG_FAN_MAX_BASE_ADDR + ((x) * 2))
 
 #define ADT7470_PWM_COUNT	4
+#define ADT7470_PWM_MAX		255
 #define ADT7470_REG_PWM(x)	(ADT7470_REG_PWM_BASE_ADDR + (x))
 #define ADT7470_REG_PWM_MAX(x)	(ADT7470_REG_PWM_MAX_BASE_ADDR + (x))
 #define ADT7470_REG_PWM_MIN(x)	(ADT7470_REG_PWM_MIN_BASE_ADDR + (x))
@@ -850,7 +851,7 @@ static int adt7470_pwm_write(struct device *dev, u32 attr, int channel, long val
 
 	switch (attr) {
 	case hwmon_pwm_input:
-		val = clamp_val(val, 0, 255);
+		val = clamp_val(val, 0, ADT7470_PWM_MAX);
 		mutex_lock(&data->lock);
 		err = regmap_write(data->regmap, ADT7470_REG_PWM(channel),
 				   val);
@@ -910,7 +911,7 @@ static ssize_t pwm_max_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, 0, ADT7470_PWM_MAX);
 
 	mutex_lock(&data->lock);
 	data->pwm_max[attr->index] = temp;
@@ -945,7 +946,7 @@ static ssize_t pwm_min_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, 0, ADT7470_PWM_MAX);
 
 	mutex_lock(&data->lock);
 	data->pwm_min[attr->index] = temp;

-- 
2.55.0

