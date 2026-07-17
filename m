Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611F306754
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321987; cv=none; b=hLUHkjyOZPlebW1YC+HKRjSH+3zHlKut35+yvXEGdmdY2RD+lfXDAV494EYyeIEG67EnHdjazqQhboz4oYzvWTgcBM+rhbkawsIxGCcKAEr+d0xCIecO4VgK2PvuXFYEyhXdnHxjQXhQiqIKbp5wTmxoSysLUeKqoAs3TDPj6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321987; c=relaxed/simple;
	bh=Kdez29RF+m6FsrlcEjGdPN28KX0lJ2ws3nkWv56Cdps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhDQBKm5STh4CQKTXdJ6J40zRuBLmjAVQ8V4JmAAm+gTQIiXuJEf+1AIhERbByZMPysra3Qa+5qwTVR5UQbOL8V2F0Kk1hcAdaHVkc7Yzgq1KEA4rfAK0/+dAgJD+a6HbZHz8ruwnpduduMsWfHbLrs+JKoTDWJqL2rhGfXjFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U61aN/Hx; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U61aN/Hx"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66825847b2cso2232847d50.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784321985; x=1784926785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fv/fL35f4caEG98+4FMRujisrJB19L+8TqSLjVkSazE=;
        b=U61aN/Hxvnjv83E9eLgbGhBhfNivmnWdwHiP+g7S89b5KGTmKZXFptyR8SRkGPvEHJ
         XoMYdknPMsWt+4+x7INPkR4ZngdCl8Vk/2cafpCef5ANLYjiYw7O4UAcrRSJKBjNuzwE
         iz1T6SWmzMS7VmoGqqM43VyAa5rCty70rfaKFa/Ya5/P9PIflVgAoS/5/C72rLF+KbiF
         OzVKAizWyg/KmK7/gyjLx3PEgw41g8mGdtXBnN4Osd8fhBtPfn1YecuVxTRL4HJ0kj31
         p2kBLMt9UWYQqxZhFEdJ4rRTbrhRjMqpPatLdUQwMTVG3oZrxq9Q63JFaazUJVeAiCf5
         l8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784321985; x=1784926785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fv/fL35f4caEG98+4FMRujisrJB19L+8TqSLjVkSazE=;
        b=rVQKz5PacZwjWifjpjP+YedrTl0DYrsItSOhoFA1+3t0fqjDtq0IVYiUqmOpVjfhH8
         z7lxxX78sEzmtO3rrQgOoUIZdbD5RoCpwylsQFs8dJowSpOvePPfydkxO6DsMyFWjwE1
         +cr+R0Xm+46HHHpeuuCNih8MHZdvyitfdeNi6leTzzuoH+25yn+LTUtO1AE8ilH/gg6F
         YUJ7iE4vcnrVckRVCP1FX5B2TUWz8mjkIiU0MXeVfUbfPRngi6ADxcNto95VgN5DlISw
         i6m3R553mgt+Gg5l9TqYgXzYJ9aeNQmCd2UfLArCMCMbSVw2+CWcN8nx7yUUNfkTJAX+
         GQ8w==
X-Forwarded-Encrypted: i=1; AHgh+RrPMtdyFCsOcFfysgaLsyg50U4WoCKj7qNrLuulM6xfq3v8WAzvNaooQeC0IWaRPkOc0q3pqTgHH+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MwCzmOH0Cgnub87p6je/nj75NgVGNDG0Qv2aNKPGAoUFjn4k
	eit2h7bveFgb3RAgRZ09PviV87dA5qWrcVgsKuv3CzlNPShUCPxCv6Qh
X-Gm-Gg: AfdE7clQ4CoEVyE9bXvQ4jVTBeLb3wGBkibyAOE/no1bZekwi1RaXkqBvbT8gbgCkaa
	jmuCR3N/uwRxOtR4V9zAzRl5R+LWPc/IyAFGJ0lqAwKrOwRXG6Pfa68q21RVS63Y+grRzIA/9NQ
	nzOwM8btFpmq4lYCd7mL2BUaifgDxKehdaSzP6LZIJskHiS8CZCopdxjKI3NsGG+qBCvSp89mof
	Rc1POZJ66naiETerxpibASplRzpbnbs6l+yufLt9sQNPHUyBs2a8Ky45hZS9ldp5NxMxtB72gf2
	UahLkKv7NmuKiG4yiWuc4RHGyjs80nML84YcL/r1Ozffa31fGzJvsY3nqzdDBjBbao2ZWs+g7iL
	sXSVRKOYwBbGxWqLoBPfEujUYhi3EziveBl4EuhzdJdxSGU2Mp49CDyqfcIHaai1OkEL55ZuoUP
	UKBaf2Ap6AHlRWvu7x
X-Received: by 2002:a05:690c:3a0:b0:80c:2365:8756 with SMTP id 00721157ae682-81ef252bfe9mr15275427b3.23.1784321985191;
        Fri, 17 Jul 2026 13:59:45 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef3e6656dsm20013647b3.0.2026.07.17.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:59:44 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 17 Jul 2026 17:59:16 -0300
Subject: [PATCH v2 3/6] hwmon: (adt7470) Fix busy-loop and I2C flooding in
 update thread
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-adt7470_thermalzone-v2-3-a55147958fad@gmail.com>
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
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.15.2

When userspace configures 'auto_update_interval' to 0 via sysfs, the
background kthread executes schedule_timeout_interruptible(0), which
returns immediately.

If 'num_temp_sensors' is concurrently or previously set to 0, the
msleep_interruptible() delay inside adt7470_read_temperatures() also
becomes 0. This combination forces the background thread into a tight,
unbounded busy-loop, hogging the CPU and flooding the I2C bus with a
continuous stream of transactions.

Fix this vulnerability by raising the lower limit of the clamp_val in
auto_update_interval_store() from 0 to 500 milliseconds. This guarantees
a reasonable minimum sleep window between sensor updates, protecting the
system from intentional or accidental I2C bus denial of service.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/r/20260716213252.EACA71F000E9@smtp.kernel.org
Fixes: 89fac11cb3e7 ("adt7470: make automatic fan control really work")
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/adt7470.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 481d51617f4b..77e7be692790 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -509,7 +509,7 @@ static ssize_t auto_update_interval_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 60000);
+	temp = clamp_val(temp, 500, 60000);
 
 	mutex_lock(&data->lock);
 	data->auto_update_interval = temp;

-- 
2.55.0

