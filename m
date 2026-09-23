Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD9439F88
	for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141794; cv=none; b=pAS1YjuRyf9ZfOCMlL+Z7fc9ydHZaNKHIDMMbFcdkJ0tocQCkElW4XshdDtKNszBQobxD37eqylGItwxyhoCpiXjODADv7pUA+DnItizaihqzrWeXq16xYzaJ6SbyKdI0sRNRo5DQuqLHBTjAi8TRb/HqiGbhwKP8AfGzaAXwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141794; c=relaxed/simple;
	bh=OJS6mQlRWmTTimOyj6kC0TvQSBszoDm45iW9XPqV2AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J68lSf5g69eJlgXN+zG2Gm88/rML6W9zzcrIiN65MwH10YGXrT6N4cqvVA4khRVZXw1dfYw7yDskHeqS/tL4ahi41gdU9fhxQhZGpgpSBi5ruGxcJ44NYm564jHPJFFYLMFsQ2yNtRdV9zUQ+DAOGypYwFvDC7+1C9BylAM/XGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxUBZbHV; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxUBZbHV"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2ffee6so279179b6e.2
        for <linux-pwm@vger.kernel.org>; Tue, 22 Sep 2026 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790141790; x=1790746590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhBI/4MYKZ9FiatfUTHQXDlddZz4ARJ+4t2N8WN0Mwk=;
        b=hxUBZbHV6QCZXuCz2XUqH4RtTWSjfTtAuoAbuFYn36LKQ9UFFzkyYjzF681zZBcisc
         8gX0HdHSSHLXMLJWsgtY7NJN8Mh3EKqnpDidPuVjlB1MQQfIqsVIwhx4aN57mur4AG2C
         DLJnCIaN41i/bMg5PjAzqI5BQQu7GQp3OGkgLYkVTaiH1tGvvvFKuBgo8QRZfr0aBtpH
         Ff+a2hfus3Hb/uK/Bl+HCweZCBtrfxN3/DSHnWNc1UatibpDktP5PmqUCHXkPQSlA9NU
         G2PmBYaijuANITHl0C8Ihh0xfNXA+UExUFohEDPfEW13k9XpVleZQAEefxpKgSmAPg7+
         wxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790141790; x=1790746590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhBI/4MYKZ9FiatfUTHQXDlddZz4ARJ+4t2N8WN0Mwk=;
        b=B8On1A8HFMj84+6Sbua1LgCS/xz9361p0pw7fONBHlrOSTB9L5v6jrCVJy1k2F1OmE
         RYY9tG90ll9NlGvgXAkAm8mcyol6IwXraZFuocXx2XCom6+rM+5gadXPV7ueX8X0aa2J
         MaINe3nMgRND/E6sYDk/7bmVPvQ+LocPrNZa3OX4fyTEu+mVP4dYMX/0JCq5jG62WWwi
         WfAH4BrEaRhb/u/6apKrzYST+83XjhSBmaQLr6DOX/QVHhQzHumnXw/woJKBrHAvrqc0
         3IAuXLrg8FrzubXaC+W7iZQ91AOrG4V1bb7tE1n+rd3l+ey/Ceh2o3E7kG5cD5Hd7FNg
         BMJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwY49ibBaXF0kNmxoYF5OY0sVtiozVsTWh0Nhm0VJM1XJWxF9LRxSsYXsZht5DZXuF3MPp5TxxCjSo=@vger.kernel.org
X-Gm-Message-State: AFuF++ksRKCItW7PTXU8A0uRvV4DhFXMRSbaL4Ju4N15sdrwwegkML1/
	Z0ffD5pqR+eTsQIqXgF3fOLqFDVIweqzVai+2FGj05QxJWxFnP3VToKW
X-Gm-Gg: AYBFou0SSNPJVZC/+psX4/YFkqdlI2A6p4SSSFkJ8hkM+AAMTgBFQocAMJXnlUWAXWy
	UnIyPL9zadueLKpqSH8d0Hv1a3bjKjQzOlUFWfuGutvsNrJ8tbZDDfycLNZK0amjFj4Z56F7xo3
	Dm0gpXs3TuxfJu7uw3ILwY/SPaHjSCLm9u6Os3heoaf1FaxPuN/lIb9HuH5RUiP/1ymGnOEISgS
	7fs3xE15uHAsZE5yO7FmB+9FPsJTDHvEedNX69nCvLPjN4zCtBwCGwUiXLj3R2TnaNawJvmsjbS
	Lrvt6hSIshn6hW8CcV8UUZRaZNIFAd8mf0+TgYIH2/pVdj2DNM9a4qMne0vJj57IYqpfZO9KfIb
	6oh5LWXkbKElnYZ/7KuNqvoHMBDCDJt4JYkcGTj6sJ2dVLnXoIibjHZ5sAC3CTthZ0jdpKNZoeh
	Rx566jWr+wSWrpdQPLYniPXQfuvV/dUN0Pdl0AhEhcSCxJR9ZU7cXtMDSZ5fceNrPE96pylmX5m
	jchpX9GlrRUgW75KoqT4z9D4jsiSdZX0E8ZpU9qmDCm3SZYmIMkCi3XH3qeU7BzHiwyb5FRosWx
	IMPDuBZ0ICZpe8ANh58L/ArYvS6DOu9e1Nj+H1wSAk1MHxPluCwuR0dTQ2AT7JxobefHcoxCEdV
	peRgh7LszJJYBFeOEV1oS
X-Received: by 2002:a05:6808:1495:b0:4b9:e5fa:8a1d with SMTP id 5614622812f47-4d5ba092ea7mr1861997b6e.34.1790141789974;
        Tue, 22 Sep 2026 22:36:29 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c4aed99bsm1436896b6e.12.2026.09.22.22.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 22:36:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 22 Sep 2026 23:36:18 -0600
Subject: [PATCH v10 5/5] MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM
 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-h616-pwm-v8-v10-5-dccebbe1aabf@gmail.com>
References: <20260922-h616-pwm-v8-v10-0-dccebbe1aabf@gmail.com>
In-Reply-To: <20260922-h616-pwm-v8-v10-0-dccebbe1aabf@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, 
 bigunclemax@gmail.com, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Richard Genoud <richard.genoud@bootlin.com>

Add myself as maintainer of Allwinner SUN8I PWM driver.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b..d9713b1044c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -918,6 +918,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
 F:	drivers/hwspinlock/sun6i_hwspinlock.c
 
+ALLWINNER SUN8I PWM DRIVER
+M:	Richard Genoud <richard.genoud@bootlin.com>
+S:	Maintained
+F:	drivers/pwm/pwm-sun8i.c
+
 ALLWINNER THERMAL DRIVER
 M:	Vasily Khoruzhick <anarsoul@gmail.com>
 M:	Yangtao Li <tiny.windzz@gmail.com>

-- 
2.53.0

