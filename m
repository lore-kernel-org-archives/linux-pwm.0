Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695242;
	b=H9lEeTRoLEvGXrhQ8vKTajzc3trj+86/W7E2eKvNClDcvAXXIcuC3dDA1gX4sV1HYRhn
	 v3zpR8yJonX2txAIeJb6KLzFeJpmQOTM+QkRmF4JIqDZNzDBfKbH71fluAi2EQMJO+Nu+
	 Le4QNYhZRfPpEISpzhXWvpkukzL/16k80wkA3f7SxDinYaoKwYvsRE4VkHszIYpF79Xaf
	 a8oUypN2D8aqzY74WTeaZnDEHVthPou41dkRAKQoaLKrhyYWlgjzWeDAIszmXy+R1LRHJ
	 TR7tK7MsBeid3PRsO0puJKCN3gaO+kDX2JGo8uxX1Ae90v5vbg/BWT6ut7n4LhDEFgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=eGQwnQ2neaJQ1jlowOf5tkGQBWxndnEwh30xNQGSIkQ=;
	b=dsxtfGrkRozV9tRBOuLVoFzT/83u2foWGloS1a5sdRaCdHTdi8bWnpkPwPI8ccVghYWn
	 O+Uy60MOXP5NGZD5TCdA+hA5Q0g9lgMz30sK7PvdNnlUHnA8fI+ujn4x1v1KGKhdpsmRc
	 LilMjoJqTxnLanX0fGG7hdl3KSMwnRKbjHe2KbV09+40fje776cWOsE4HUp4m42P8Sbap
	 ibmp6/b/z5Doo7tZaZ7+Dql6z++0FIb7gul8yawyvaZXTc37wD9dSBgdlEWRWlWaSHMyz
	 YeYy4o4uvDcyuAgVzb/+zc8p41zYFvkVBcl/9n6Xlux9OFUXZ+PMAfjd/WUSlpxU7Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVBCXhox;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4C606C6BD
	for <linux-pwm@vger.kernel.org>; Tue,  3 Nov 2026 08:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E4C606C6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVBCXhox
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-70bf1671c21so2252583eaf.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2026 00:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695240; x=1794300040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGQwnQ2neaJQ1jlowOf5tkGQBWxndnEwh30xNQGSIkQ=;
        b=rVBCXhoxhmxcS16Rq20RgtufsPsPsfPY/X4cIh38MFyg3Ep65ewQXsub1G2U5YcDmy
         ZCf2cwSJyWoRmQtmJZSwBlslK7OPJkX3Up1+7lZeQdfp9XFh7Nu/3Jc/0P7ZQlGA1Mum
         fhlONm9vM5YxgiP0e2aX6ob1VgnC8beVvVfjyibq/72fwBpEbxSzYIQF/Bp3476FaaNL
         ZPkd4y4pAaX7D/QPZCUxpFtsPpoEczYnzQkZYVUAemz2pwzhDH+NFRLovA27zeoMpVnd
         OWNy84whZBEoGPR7Fu99JC+wW0/tWJwTCKjBjxXrnvDqWXUgqiw/v03HbsGT55OV4Yld
         Zbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695240; x=1794300040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGQwnQ2neaJQ1jlowOf5tkGQBWxndnEwh30xNQGSIkQ=;
        b=yUqsfQpQFj/FsXccqToJ7trd3Aq6sB/arFweI3hHLi/9RKwNgNr2998OX2huAGlvfe
         3SQnU+ymzzXMsgiNOT8YYf5hGRbECjoU1lByGM0I7nj4ZLFc/VmEkmGmC4jGSOGOwLVo
         7i0mXeTgBKrPjikIFpvAxrRgTpSs8Nc3k4x7ity1lKgnq9lZFgrHtWMNYSdOD+a/DNvM
         F6kC8Wssfx716uAO8o//ifEO048abHrG5rAb731a3Qxf4SxcFB7/GpkYc14Ox9I0pITV
         eiMG1xu7dhQz3QSiL4JWYPGeXapyp71EwohKUOHj1n+OC9CRrTAGxzutfBmdVYt+miKy
         qb5A==
X-Forwarded-Encrypted: i=1; AKwUvBzjlyyHNwV9lPWeztBfQnncckOviqSejKp4t5bqIpo1xAwdFkystvRdbZkToWEBgR4gzjGGqCGh/rs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Mdp1i5S5kunkXvs243NWWXt3R4EDeY51HyB5Jn4H27zdGI/9F
	7asYuFSg19Uy05WxufAtet6YV7jLrDxGqouWJpWmhoEH0aX/v172lAmX
X-Gm-Gg: AYBFou0Y34BUFT/BleSgVv6ccc7t2/ZlIn2joTeTFB5ruweKm4Ylsb1Pjcb37ILvTL8
	GLpgprAtKSQhCrhqyhZU+OANTUTZr5ewXYO8i8tlrq6ZJfGZ+Ahq+aDkaPigzU/ftFJGqmKJjQe
	anEAm0Kc/CgW39DPD5jvP1Iatv6WmZvcOdBkdXmTYIvO/10fFKa+/SFNqpeBY09+t5fl4o/8dik
	Nhyaif3/bcNKvg7gjHXYtnh3Ek5zJGiDGdUd8BfWjih4g+0FkAHbJG858f6boc8vH8Egb09SA7D
	B7gFXpdyhn2fVk9EXWuAdLEsfC0rMU80Ci6rVurGxVBZ/3hnGY8jFvHwqNJoGxyV4oPg6byQmcz
	NxVvaqgfh8ta5C5feSBKf7S8kzbDv2IuxvR3DsRdfrktD8UKfvDpZQQJMD+O4/z1JGfUkOLtPJa
	mfSq18eZMmThYhxShXyJu509voKf7kwZhTSHJ4UiGUzKNOMqMEWSEfpEk/hWPEiNPwbYzjdCgQs
	S9ofujQplCGi0QbWMpIcyga8CH5H80Rs3ffMDNr9GQZPfVEVkCbF+SOaeacY6AYHQIHu4qd+LON
	ED1e0VTMOSnPZthjst7YLjOWNzgLNFw0VJEPFj9teMlwVF5XD4t+B9KWusIe9von3GupcDB662J
	7it0CLnSQ+7Bc/rfHarkm7LdJtbJygwwPShl0v40mDz5zjbxDXEr4Vzwt2IhTWLAPcHHo262Urh
	ooHyNRRfaJjAlEBfcr3ifFinwP4JU4aijhLWJAU1o0YOD5Vq7hm0FlOsFokjoiCj7CMBdUfCRk
X-Received: by 2002:a05:6820:221a:b0:702:778c:ec5c with SMTP id 006d021491bc7-714f29d36c6mr6837555eaf.53.1793695240569;
        Tue, 03 Nov 2026 00:40:40 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f3081097sm10520397eaf.13.2026.11.03.00.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:40:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 01:40:29 -0700
Subject: [PATCH v11 4/5] arm64: dts: allwinner: h616: add PWM controller
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-h616-pwm-v8-v11-4-07abb59575c3@gmail.com>
References: <20261103-h616-pwm-v8-v11-0-07abb59575c3@gmail.com>
In-Reply-To: <20261103-h616-pwm-v8-v11-0-07abb59575c3@gmail.com>
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

The H616 has a PWM controller that can provide PWM signals, but also
plain clocks.

Add the PWM controller node and pins in the device tree.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index c6b3a3f8359a..b6580f0c6e0f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -293,6 +293,17 @@ watchdog: watchdog@30090a0 {
 			clocks = <&osc24M>;
 		};
 
+		pwm: pwm@300a000 {
+			compatible = "allwinner,sun50i-h616-pwm";
+			reg = <0x0300a000 0x400>;
+			clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
+			clock-names = "mod", "bus";
+			resets = <&ccu RST_BUS_PWM>;
+			#pwm-cells = <3>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h616-pinctrl";
 			reg = <0x0300b000 0x400>;
@@ -397,6 +408,42 @@ nand_rb1_pin: nand-rb1-pin {
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
+			pwm0_pin: pwm0-pin {
+				pins = "PD28";
+				function = "pwm0";
+			};
+
+			/omit-if-no-ref/
+			pwm1_pin: pwm1-pin {
+				pins = "PG19";
+				function = "pwm1";
+			};
+
+			/omit-if-no-ref/
+			pwm2_pin: pwm2-pin {
+				pins = "PH2";
+				function = "pwm2";
+			};
+
+			/omit-if-no-ref/
+			pwm3_pin: pwm3-pin {
+				pins = "PH0";
+				function = "pwm3";
+			};
+
+			/omit-if-no-ref/
+			pwm4_pin: pwm4-pin {
+				pins = "PI14";
+				function = "pwm4";
+			};
+
+			/omit-if-no-ref/
+			pwm5_pin: pwm5-pin {
+				pins = "PA12";
+				function = "pwm5";
+			};
+
 			/omit-if-no-ref/
 			spi0_pins: spi0-pins {
 				pins = "PC0", "PC2", "PC4";

-- 
2.53.0

