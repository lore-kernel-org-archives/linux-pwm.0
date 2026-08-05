Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B147140D
	for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935761; cv=none; b=FOqSsbLkkawEVzdoWfuRyF/2eStFjGVcroHQKnCZm6gKlp9v/73x5Tl/HO0PG+GDzCSo67cJHOw3C+j1zLsXathbXnME21EVVZJRjaPNIzl/Ep3O0Udl1cpc1qT9zLwxALivdgnyQEtl5xEMkmY+N1nUkibrrJazcJ/NjYCtUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935761; c=relaxed/simple;
	bh=+gw83Mh3Ir+pTpfrq0+pitALUCJUqx97EkYCdiBEbRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fn3hAOQVvgokqRnrjB2GC4hNFZJo280Ue2+DuhaVICdGOuCx2S49Uy/glAAWPLBX8wc0Hq1fjhXFWwBuqSTDNXxJd9Vv5oz1i7fvpplOkjtY7Bzvwp//OP6OcheNIbtQ5Kbum0b/Yv2SpfEKvBhJSCHsmsFfyFC+HP4uJe/Ls1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku0EsZGG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku0EsZGG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso8681205ad.3
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2026 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785935760; x=1786540560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tv7r0pILyVz8vcjgz8J3/h+ifgsbbGqBLwmu7dyifLA=;
        b=Ku0EsZGG5qLwyKd1DIO9dwrzIPWocFr7AkGTsPDRRVGLc9SaUnJOEiF/nekL6gD3VR
         W2o9GIv7wrCNi0dk9n5pHvCKEQvF48W4npvMTk4aKoZJIyEE1kUR/aq0YrsBsHnWBayG
         fVXPjJsnJOYbvO+aTu6SPqYdk9k5kWOKA5m3sbrLSynkePWPNuu7U3qOmbODicaIjpPG
         DMX1BqQmIX/BBsycqviMYuu9zTwAhGtgoHm8HZY/T63ezrvAhAGN9ZTS9zngVDNNvqhY
         uR5iSq6ACw+zKr16cZgpp/PSKv+elLvpOi+GvnWQPML0cF9MPxrxn05TPpI9fiqCBS9k
         4LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935760; x=1786540560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tv7r0pILyVz8vcjgz8J3/h+ifgsbbGqBLwmu7dyifLA=;
        b=SQCCLvaiGIVOvebxx2qjp/wJWsv7ZlOreDpKHrmajHpxBfmrg80IF4BvdWV/F1LGws
         FrukytxpPxS+X2P//cCK5isI+U60M2B3QqycsfKZLS2zJeY9ajtdGnD7AwV5zo1gI1d8
         AY0uIqHzhh3IADsneTlF/+Xv6yonexMV/tb4L5ILK/2WV00QzTM1Z1sjZaJp4vJs1xNq
         0MceDLGnErhnBVqucJFesVL+so//+d7Rc5mQPESY01jbJe5VUJNxMUq5pj6ysCn/MKXD
         YTpKvYFvCT7OVxz6GSGEoVPP70R5q5ZeNfVgxQfSUSACwLIlo6k6tEPYk2hg/lGKJsgR
         8s2A==
X-Forwarded-Encrypted: i=1; AHgh+RqHmy1kSu02hZTJGkRbgNPvTjNZxQHO4qQRzRmKS1a3pEhKxFnF1OjUYS6xv0EsBcAe0ClRJBZSURY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LHNxIht+QrGVOcsyynJBLzBLpmStgRbfeSTglN89r2fujKr2
	eYoiABN6EAkkk682LnALZyX6G0t2duZQ4oCWKldu+vlArn4LHIeXmUCb
X-Gm-Gg: AR+sD10nGRKM5b+kQ/nYexmvIL3nuRpBfUmI/74bglTxneC5nqbxcgSYwQbrKBS4cz3
	ISXQdRqQzOEG2o7bIBizaShkr0F+tk9cS2nRZzFz7dEC2sZwl+4vWNRbTepFBTz2Cp1Y4gJVFzc
	kVgrlGkY2VJ6871lhnpPbpknaYdcdjZCvoclZqNbmuZJ7VI8HJtVt98/i+T1vtdsN0++ihUwXPq
	EuF8tL5YbLzs1Zsxq/kKlPMdrgvyHVgwrPJMFjITdOiktsgqzqesgQnYPRvvNMYwNi+HyMhJtU8
	EP3G6WET4Cnj+AhFvpr2MNf3t1X7vUccwFg+D8ovyytOTzNkbqwlKCiYZOZDYJNgO1HFK2ziCcZ
	ObC8myp0xjnVGRL8YGyijaHbxtw2JCv6GhYW0AAgzp07jo+73JyKZZEaVSFTvNUjneH7hz/yHUd
	dgtWfsh6tfP5qMhlF5RjGH0gmr1yZwlbNhu6eQisJDvtPRMiD94XNjrZskHCcxITcwcrrZ0pfl
X-Received: by 2002:a17:902:d986:b0:2c0:e2ea:6b0c with SMTP id d9443c01a7336-2d0caa031e5mr82849455ad.21.1785935759549;
        Wed, 05 Aug 2026 06:15:59 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([189.4.123.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673a9e4sm18292261eec.18.2026.08.05.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:15:58 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 05 Aug 2026 10:15:20 -0300
Subject: [hwmon-next PATCH v6 4/4] hwmon: (adt7470) Add thermal zone sensor
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-adt7470_thermalzone-v6-4-5605a5f95467@gmail.com>
References: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
In-Reply-To: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
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
index eeec3db0da88..f652532f2f32 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -1396,6 +1396,8 @@ static const struct hwmon_ops adt7470_hwmon_ops = {
 };
 
 static const struct hwmon_channel_info * const adt7470_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,

-- 
2.55.0

