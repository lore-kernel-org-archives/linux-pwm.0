Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918835E1D9
	for <linux-pwm@vger.kernel.org>; Mon,  5 Oct 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194790; cv=none; b=fKoiAxMYgzxaRhYXKpGvqjv0ej89J0sC5empObwA3g+Edgnibct85xWuU7tMuibcXfSQRJ4Ppslsk1p9R0L+3fpU15VtdSaBwQ11OKrg/p9mP5jfbo7GjpKcqfuyDxC4JRaTFuNkfUDreuwrirO7p0v6Htc0RycXs2yMckzhZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194790; c=relaxed/simple;
	bh=kkvQVRadmIQGTvKLcaujad4OYyUKVMAdBbtxh9GnyQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjD2uvqpMBRF0hb37kG8wZg4cHl+ftoK7nXt0A9Dzd4jnpCcpyVhDx8argkiH9n1nNHi3TQUblsEY/F/RYaNlgofE2/+2rNpLAXDqcTA0K/qth2Z7X+CM734BKWKliJ21JpIZZHnSy34Tb3D0SCvIfEldAzrmMPEEEhXVKhS5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=huoVvb36; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="huoVvb36"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2e6892b3faso133535766b.0
        for <linux-pwm@vger.kernel.org>; Mon, 05 Oct 2026 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791194786; x=1791799586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SsiKtn36BJ7XHGErl6qttUUVPC9Oz5hd7o1Pd38Jb+I=;
        b=huoVvb364xIOAJ1XugGgrmxW9z9ErIPIYiUqeyitofQqXnLoh1DVSyY2qbg7MGlVfx
         Lb7tzEgDjILZnCabRDcKwrTP5ABy2jr9jcG9zEWkZVnid9RLJBiCHeYDuq4UB3fxRgb1
         r+dpvjSbwdF+w6aibdf0AEr93FTWmrsNlhzOG3nJ9jrmmqaUuZdiqa0Lj702y9pbXZTf
         ESwlc105MS+bxkjx7sW4asb7DnmX+JbXT6QKVvz6EszHtwV8viMrmyGYtE8ir2X+Rp/v
         cD6zCl3xJT7bRz06IEQc6cMj404N64u/iIJ1fuW26+AAPhkoiG8pu2e5m7t6GRdF4fE9
         gxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194786; x=1791799586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsiKtn36BJ7XHGErl6qttUUVPC9Oz5hd7o1Pd38Jb+I=;
        b=xyI0sTaxXk6WZxKJu6lOl9+01kVdfpzrvkLNUcSD4zrfQrHdr14M9LIev5Hg5VtyKF
         0uovT1/4OWABm7PdrziM3T9IpxId9LELoS1poiuFjwloyKedfZQ7L1ivfY5pdR91n095
         Z26/1jWfEF42/jAEQTzXmqR/RnBjvPq+fi8db8AYHXYCk46M3xQe5RWLGUfZ2HkA23KC
         SOxDxI8WngjZlZArTyW+gMSNFd+gq5PaJUaYFarAt1rQwubxcEpNSYxgBgMX8Zca1Sfk
         l9iD42jfoGe9xCnfcYwuzH2VPP/9ZxzDYyTjWSjIUN+oEPPoUSoJM38tQmNN8vjl5/F9
         fsIg==
X-Forwarded-Encrypted: i=1; AKwUvBzRFp/zXRT9GARXI4Rxc61qqGXSpwm+SlB2mIe8PgXXXBnGfwJT7U7DJdeAJ3DmNwR+qU9lLji+PsI=@vger.kernel.org
X-Gm-Message-State: AFuF++n4Vf9iV61NQ+2YQ0wfA5RDwuU5QNk0I2ImmWq074V9Q8oqZlLH
	rwFhAqTNSZHmPQfKBRyblTBEDBBoKrIE1aaPmQJ05OVCpXHKSDekLHfwAGknqbGTBNoKHSX5XrU
	npDDJ
X-Gm-Gg: AYBFou31bRyhCAYBYrNZtlPj9mPZ3DdTPX77YL9iJqdLwCq5GQIFJH5y2/yTdOmyFdW
	5enetXUrpqC94XkuDl3CcV4x813s+2vW1/eOWUbctEBQ7LbmLqhxtlsb8ZJ8tmY2oQ0IoCMxWEv
	tv+JOp8lm71z3SoUtNIkXTGACb0+SHSjFQMElDjmQ0PNWvYA9N/qTAPfHWH8htWgW48wSO91sEl
	LKjTI+jfh7jYUaGi2xjZ3Ifg1zI/18WI2hWxkHSFdzTPCGkFMu488dbAz+ikb0lc9KwxUV55xkG
	LqhiNK1B86lFxiEj4QBtvWzAnTpzpu6ZJ33ffXwWLCkwZrTRyhjh7TsGd0z17d8FrHf2Px3kOLE
	u3+aU9FljyXL+EQNdXT//BARM7l57qOD9gL+Y31nY//s9OKg2AGwjZySnLxGxpzHmq0PdkJXyFD
	YPbXoEC5kGBT/S6vWSBbNpH6RhkxK3sltMSTFez42Vcmdr5oa4hJm3xjl2eqGMygAK+5+pDdgpZ
	UbuV0VLaiVeuMrZUinZqsQz2KSPOqT9ybkvB8E=
X-Received: by 2002:a17:907:7212:b0:c29:f5d5:5aa1 with SMTP id a640c23a62f3a-c2e4b295951mr836086766b.43.1791194786464;
        Mon, 05 Oct 2026 03:06:26 -0700 (PDT)
Received: from [192.168.0.42] (host93-7-32-195.dimensionesrl.eu. [195.32.7.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3156360832sm50800766b.75.2026.10.05.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:06:26 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 05 Oct 2026 12:06:23 +0200
Subject: [PATCH 1/2] m68k: mcf5441x: add PWM defines
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-wip-bl-stmark2-pwm-v1-1-168b9dc653f2@baylibre.com>
References: <20261005-wip-bl-stmark2-pwm-v1-0-168b9dc653f2@baylibre.com>
In-Reply-To: <20261005-wip-bl-stmark2-pwm-v1-0-168b9dc653f2@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add PWM defines for the mcf5441x family.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/include/asm/m5441xsim.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index ea01c7753b7b..aa925fac87f4 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -375,4 +375,11 @@
 #define MCF_IRQ_BOFF1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_BOFF)
 #define MCF_IRQ_ERR1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_ERR)
 
+/*
+ * PWM module
+ */
+#define MCFPWM_BASE		0xec088000
+#define MCFPWM_SIZE		0x150
+#define MCFPWM_SUB_SIZE		0x50
+
 #endif /* m5441xsim_h */

-- 
2.55.0

