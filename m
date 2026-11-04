Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820311;
	b=he44EYIk0DBGFVOiBuP7fwFaiCp/FOpd6jHgr+FJuj+RNHDLEadXaC2GpxBz1pSev55c
	 NI2OtdPm4cuzfJjT4Re1SJckoCWCoSp78oGjSVT+P5lYrp5kz13Mb/KDfMvr3cXBf/5X9
	 Ma92PL9SyRJWLQbLigl8O+bz0FISycW1QHqO9MqfpOCGNp7eBugBwEuj2pKFfMO06ggg9
	 aH2nq8FwERfIbvm5+hrnL33n0OJCNu7L+pca7eY9aAXkhtKE6aoGVlG6sQS8xYFtCZ/2i
	 VO9Bp/QsVXpkL7l/mkPGJFjfUyIEjc6matc0T0+W5U3K/xqyEnP/LsC51NWjAtjf8ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=eGQwnQ2neaJQ1jlowOf5tkGQBWxndnEwh30xNQGSIkQ=;
	b=UqU3TGSNkR7bi9dsgbW7jPQJAAykyvfFVqNyJtSDGZOgMJP4WW9nrAYS+XM5qXOFcsN0
	 150HSgWhgXrE7MNJsh25NT4+wKWsRnTnv/GTzDVWadfu8LjLshKrqDs+pgQQ39bloGhYI
	 kqVEZHoo5eMrY117pk92RBzSoEUMWgV68pvuxH3CHvlumPxoADow2pYQIrbV0zBSaCZ0K
	 IVsHr7vl+REgLuhHLy62ZyFl/r2YxgN0RO0rEa6qJXpA9BiN+T1Iscns5o0o+uT3neCT1
	 Nm+ZhUOHNZagpdTg8+f/ixIE4HxWAEKIVzJLqJ0hz6mMjSq6l2MOU5/vL4+fX97OQbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlkBuxiW;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A7607F2B2
	for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2026 19:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D8A7607F2B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlkBuxiW
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-823e4047037so772793a34.2
        for <linux-pwm@vger.kernel.org>; Wed, 04 Nov 2026 11:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820309; x=1794425109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGQwnQ2neaJQ1jlowOf5tkGQBWxndnEwh30xNQGSIkQ=;
        b=xlkBuxiWK9mHFZ6iN9g5y0fn16X1yn8UtEixLRdZoFQcpS9PdMwLdnlMrc4WbhdhAk
         4SF8uJyzjT/KxvKs9sPQi70xklj1OFYTi9nUPICSitilZ+yxHJ50ss9xnE+zczj3FAJi
         J68fk/5fDuCYRUhQGTYbx+rrKWWtyHiczRhwTTbuCPgH2qnG1rmrjDb04FqMblkYZ1mc
         vicUzM5h3sq06bE8GkOhNKzef9nYi1s+jJTe/76FuZLPTctqdFP+KswhdQJuyBiyYjip
         KaREhMZd0iFR64nR/VgRuNUYXFNoQ3HqY3iAcnB3p5yGnyge/AdHM7M/JCQBb8e8vQ01
         QTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820309; x=1794425109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGQwnQ2neaJQ1jlowOf5tkGQBWxndnEwh30xNQGSIkQ=;
        b=knfrUFT8+eD5lqtovZC2rFIudpb9dD+MC5Is3XyKSk3+RJaGGZtXUZlOOz+riF5MaD
         djO0DOLI2fjYaF5BSwO0MJsDGuHusDfeMhoRjOqSI2az0rTBcjPbUhV5NkA/UiDWlhll
         eaNEjZdNbUuJAy6UNH8LNJ/RvOEgkmJrLLW3f7MOh3AOnu6jGdXvzFYtbSnTf+UkdMJ8
         oPZ8M9niOmz3V5H+zfuPjvxc0TsCB0nb2e0YNEYi+hQFhouOqCZLLLEp1sr87zIpBV+n
         piNnxB/awDNFvlMgTvA7AHrDx3D0rk4Yvc+TG9MrJhtesmy8bpg0m/KPso8PLo72lFn7
         K/0w==
X-Forwarded-Encrypted: i=1; AKwUvByQDoEAbV9Z3vrrFB06zcpVHCnqCkYnRdwCgK677WMAYFFfcXf4Oypd46OfVKt4LFPIR8uGgC/9v4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/S7kk0dVOuDAN/fXffi2Kd3wGnxZl6X3UeXYFPzRa2XsSbePv6
	+S6lmdwdDsIJl1s3Ks7V4Rph7DBVNKx3oD+Da91L6vOEUC7s4z2fYoeI
X-Gm-Gg: AYBFou3sc/RMid4sgoNLIZVnCDd+QsJXWfBQSORxnFTG8khYHdGoXTHINM7wdNCJHvp
	jUA75qXMUlCEt9Y0qB8qczZzHuejAinu6xwMFFkoJBL+AyP1SwFfcHPHwlpBdw6EGmJkdpBuQkJ
	UUWEYNnF530ga808H/9SZPW0rq/lIvr3/ZPQbJJPdXQ9Mu42hIScOCXJ/XayPr4rCtawWD8RlxH
	cwQOG/MlkzxY4XlQnSb6NupbOw6cRFd6hLEH/KQgw6EkWmO0GOIfBlNXq9U8P5t3pOxsmRZ848Y
	0bCd1vetyVv8yWKzIY/yM92k/qDEh0/nTYygmwUaZksuj25oPn1SvXUR5i9Yr2WU9cVaE1mjRBJ
	wl1ElFR+c/e/bIbPrkgNX6N+onS7q5ii82qxwmmf/tc8/r4lZic7ex2VE4ajKSf1hjCSkM9D8iV
	ezeK5Wm4qlRhQf8M+8KBwLNqmW5ZOItkXD0GVVh58VlPFsKpTGyqC2sT/fNjX/0lMYC+s4mFRdT
	neJDSi50152JxhtYUkp6+iGmfKehrfjkp4AUUKPspyAOzGx2HbY1QWEEZxf7p3DI11Yo3shCLnV
	PCN3GHP3mkK8BRc0sTIawkdteQdwIFGIcEulH23cW+lqaCurv/CRVVzb7jzT396pSG/OLSO1c8U
	p1jX5EWWrLsdDl8miWl4P3gJTbvKYXCYgMSOPCRC6H9cNrqssl+bbJ2JRbqSJ4KC98/I+HeSRB2
	8oIDsGd81NwKGs2rNL1He5o0ani9QbA5XUAoZvNmQKBX9lrwvhF/e6
X-Received: by 2002:a05:6808:2218:b0:52b:7641:33a6 with SMTP id 5614622812f47-5640deea502mr12233182b6e.14.1793820309111;
        Wed, 04 Nov 2026 11:25:09 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9c7bbcesm2328723b6e.1.2026.11.04.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:25:08 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 04 Nov 2026 12:24:54 -0700
Subject: [PATCH v12 4/5] arm64: dts: allwinner: h616: add PWM controller
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
Message-Id: <20261104-h616-pwm-v8-v12-4-8ed39b0dba69@gmail.com>
References: <20261104-h616-pwm-v8-v12-0-8ed39b0dba69@gmail.com>
In-Reply-To: <20261104-h616-pwm-v8-v12-0-8ed39b0dba69@gmail.com>
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

