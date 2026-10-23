Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750352;
	b=ccztECZZATJPT02971db0TQxq9zHRonGPDAdZ02fN7LAYTAU+a9zmx0TB/bS/bRkoYQw
	 AyOffmH6UHiHrerL+ZhYuxUGcAhXA3NY7zuMFgyCrTiZq/WoCFc8ZqX7rLtwzd2yvYYrK
	 Gwv6s0i6xmeagHbsBivuPzcOIiVdEtPhmmky70UHDadH33K0GCvhb8dUKlLZ/jh40Yv6+
	 TWSBdDZQ/nvppmSvVJ032tF42Gh8amxWGXMdCn/pLoCNxATpWFrDobQHvXUm6dWikigbC
	 3sWvTxF0z635tNirpgQPSWpegFlIxer2cwwZVcYmOXlBx37/pTA8c3wN2rjuyUktKgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=is7L+B2RN443PYwwoWeq+UVhGmTjVPpzuTGcDZVXmgU=;
	b=aZxdC5102Aq9wNg0OyAGllHNbkdVblU6zpuFNnoKAOSgfWQzp+mGISp6Uv7yBHhJKHDg
	 sJXm+H+xJcE3ST5xPoCYgi/92iBsVhAi8aKhf1KMujC32qL9tOeyIZ704g6Ud5y4KRJR7
	 /jga7tRRqYf8UsUgRml5RlKi2VAJc6DxWVpzBWr1knUAV3oYjbdWzsicOlgAztk0J9JYw
	 sQRtJ5knbVnS+DNiCfTDVX/ebY8V+Nmp4y4gaQw9kI813/MeueNXyF7wmuQFsht9dYsGL
	 Z7nmxLueRPHAUraYgo0X/efWbl4Q8yd4wrVOlVaSuB2mGRbIhvkv1XeoRyHsFSUB0PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TXZQvtD7;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECDB60A261D
	for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 10:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECDB60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TXZQvtD7
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so4316555e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792750336; x=1793355136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=is7L+B2RN443PYwwoWeq+UVhGmTjVPpzuTGcDZVXmgU=;
        b=TXZQvtD7jcqOHabVOR/WQ+U/XG+v8vjWM/Qmsl/q6MzNZD7uqig8eGptjZOesICJ+P
         ScR9lJVpLDAQrN6bNGDoIzP2zfnTu0iNIW4E5ihRHRNcomwDgzhBfltCJErnLQgizFnP
         S00llh1bjJPqLGcEzS6ZFocGV5WDpL85Le2xfNFTfrCNSstwYtpe0mbeJ7qhc2DHuvOL
         Bcjx2MtcWUMSzpiVgxQRtlhn14/FrOMDJtRIiMOO9EZURIdpIZTJR+t7d2Y9KJAc7J6f
         3cj1tMnVc+viMiKK80xqhvsvmQcodKjtbWVwwE2w7iHG+6KbtBrtw84P6UpgGVAD0/Er
         MGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750336; x=1793355136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=is7L+B2RN443PYwwoWeq+UVhGmTjVPpzuTGcDZVXmgU=;
        b=mO7qlS/Fd6S+CUwKfNpLF5U8eJkVPWg3Xrvi6LD6RCiSk3Nr4OFtvpIAKFggxst7Jk
         dGXn3FGJ3giEXpI4Snx9s7/Ku7utr+Z+BqWZLoBxHsI//TB8ZyUyvQLVW0pknwyCzCBN
         sqmYai8Ly+Q72+9ABeEGQoGi9Oo9hC0gqeOR9Fl1EkztJ3CdRcc4sXuGUQKzQTDX5PL6
         mZ9RvQ7Mt0MT5NIl5L4qOURxhiKXt9rPkpM6yOSh3VZjXLCUkeMpJtC8TZqMfUUtL93B
         z3rER88JGpiiU/Vt+YFQy8vkYpWCo/5JwXQ42KofQAjn7xOQBzHjCsbudqUyrnBCL1FP
         OS0g==
X-Forwarded-Encrypted: i=1; AKwUvBzqKVjHqvb/jQPztJ5w92inj9G693DQKIXDsaazfZ+dlQVKjd9X6XASNYWaIPkgIBvVDPOX7IYY1to=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO6Vhf9AVtdgrQm+IJa95COvpwEZlsuEiqB7z7lNofMpgOsRrl
	OO5smMjvxM66UIrtg00ks1lHLMPWrtwPbEmUqxrQQKs9P12Y3Hlcrf/tfDwKOOQoHbw=
X-Gm-Gg: AYBFou0vU7JzL7ATYm4BzUJwzkwcT1+7xkYFS+bIk8OLzf9MnOSqDXZrtlHYjdivi9+
	GJwdkck0ruwMQzSP4RdKA8bXHsj31SRrxMpACMdPcygsYBCPOqbvOYFFg9UmKsUtB03QQL9Seo/
	oiaFz+OkaXGIuMHZy9K09zap+gRxj1/4mfO+KAYPvPxxbUr9fMLnftakGt6Y5iwm7YlfNKjpWhf
	SrXOhisNSKzlCOXHz8sH1tKJxDbmlj5Vp3kBYljm+CtWrC8gjCJBPpJkUoo3oD+SHcL1Ia1Djfy
	j7+tR2C7CVMnVPSH0lRtFZGmQlCmrRUo1xQcj9h/KZQU0DcibwkwW6ypunxeVVOA/sOsjWdunf3
	LJ/up+5kjbldGtZTU2+jC6a3EOpN0VMjdCNk23Hi1w+uOCjYKT/6GmtBd4n6AM8ApQTbXLHoCvL
	lXAob6GFaAHISWy60OPW08b3d/h2uso3CL8oKaBDicRvlwovcqax72PVNbK6EESNSMePpxqDuui
	KQYMO5KQ6YknePRCtbJIRV29bp7NETD8CMlLnTSA1E9AoCOn/Vrv/8umtf1AqkkUgYH4Lg5uixU
X-Received: by 2002:a05:600c:3514:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a211ed7602mr26707515e9.26.1792750335754;
        Fri, 23 Oct 2026 03:12:15 -0700 (PDT)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211b89beasm57982975e9.5.2026.10.23.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:12:15 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Stanimir Varbanov <svarbanov@suse.de>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Gary Guo <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RFC 4/4] arm64: dts: broadcom: bcm2712-rpi-5-b: Add RP1 fan tachometer node
Date: Fri, 23 Oct 2026 12:15:57 +0200
Message-ID: <f00b7ccef721c7120ac10a9507ab211773787aeb.1792748691.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1792748690.git.andrea.porta@suse.com>
References: <cover.1792748690.git.andrea.porta@suse.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the hwmon fan node for the Raspberry Pi 5 to expose the cooling fan
speed (RPM) to userspace.

The fan tachometer is managed internally by the RP1 PWM controller.
This node uses the 'raspberrypi,pwm-tachometer' property to link the
rp1-fan hwmon driver to the existing RP1 PWM controller, enabling
RPM reporting via sysfs.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 748be8f1ee9e2..9bc6d0e9da1b5 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -16,6 +16,11 @@ / {
 	aliases {
 		ethernet0 = &rp1_eth;
 	};
+
+	fan-tach {
+		compatible = "raspberrypi,rp1-fan";
+		raspberrypi,pwm-tachometer = <&rp1_pwm1>;
+	};
 };
 
 &pcie2 {
-- 
2.35.3

