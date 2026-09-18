Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9062436BC8
	for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725337; cv=none; b=EZLQi5Rm8B0e6QcoyYvArsOly0a3IcfzutY/uboBWh7FdrPyy8gBC9QToitJVuatmKLaB1ZXSJeRsEbVGArjYFECm3LBLL+T2kg1O1ozti0VbCclrNkcDvvrrHAiCQAaYpg+PHMa03MgnwfF1KonDQVDxwnzw6j8xeiSDSk3bgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725337; c=relaxed/simple;
	bh=NyT3bvkYhBzVis/qc4NVpDUc0HxiHbXcgKHaKLAMasY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hssdl3wcD2vI+Lau/yV2z4/XpGgw4CAfy7gxvK4vSqKHrigH5aYKK2dL5xh+9R/A7nW7L6KxVaFxpxBw2s9JsdAbEaibTwIOxq2hk3slXcqKDVlOPMI3+2LhZN1jFXqqJmh/pYlyL2iOnhgOK9MiFmybI2SboGS+WKRh4bhFTX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ICB15+dM; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ICB15+dM"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso405798f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789725329; x=1790330129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=ICB15+dMW8qgOThkSxsnuoekJONG4TpcpLrrqabzQyhY67+KGirTMj/xyuTKbsvmzw
         2nTT666mqYUWivLtnqIBiKk1mjVqs8hKYmvokDAC30ww7stroOIETdV5mekvKP6e2Enk
         J6HGGwP1z5xuJXqPlEOutMW4z6hSSY+5vNsufn4lfPHDZsRm7nWtW4WYA/q5t8XpxxFX
         9dQUo1tqOzEsoXlEfM65y7QECASTu+h9gafAHHlhjxGspKDu9rl+FxxBstwwWL30L1X8
         iJ4gjx+ejLTGp0qZjLL+IUOb43z92KTTCjXPAnAB+Arqo0rvJ6Y8xu5Vst9RtMO7cnDI
         fgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725329; x=1790330129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=AMsI4V3RRDtLMWC4rvPnw5C/k3dGZNsdPxNK2jhUnXoT82KmSLibK8MjlsUPMdvSb/
         zCvtTwyFyrvwCLE52kDHmbZjVDkIdXAAJ7ELsAf6icJcafQc0iqVl+A/pmeBikTF60KF
         HooE0mCw1G0ewm7OtCFo2B7PV5ljuaa4yVa3xd1Os7AKgVoDcXAxaauKVJrmHED1PuOU
         mOU3RIZWOZ132rjdDlJ6AB/OxcJyIH4hZQwJnwmydpevt/SAL8AVHNd1NvXKl5GNgC5n
         LNiAahDeKxBIomk5bkLMizZf3bgEtGwKEDqfSQw5rj7Qc9M3+K19cua6TZY4awb/iV/5
         5AgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO1+jTTu8TW0EemB9r5acVnw7HXGA7jXcsEnDzrYRlUM2c2Eu2fMCGijSLzebF1FfhN0SregdlQm8=@vger.kernel.org
X-Gm-Message-State: AFuF++keyadKIuzGDtyZChmxkprqfva31upJwVBKAIioK0cgeJ56EO7S
	tkVpra6NEuszFgSwODHAEollOUT976ko1zuGT/MP1pp6tvsrIpHcDt9GGXday9rJFHs=
X-Gm-Gg: AYBFou1LYworrexoQndTyBSx5fYi8UCzakXDGB1hkOEve0qAT92mpBLTF0wzQ4u1/wd
	d7BdHOb4Dc9yddKKknyowR/mrx6/d12Ayia4BkvNQzAoT89F+vRw5mPymo1yQhtEtSXheW34AID
	WGqIGu3FFYxEriL8cKQuC24yqdrkyxfPdtZf140EDPI2QhUJ0j7FJGdz2eajemJBC2sVsByxmz9
	brhS3qlOYq6o+B27c4VeCsl0y3jyzO1urYM+qWkCBUFPHu2PC/Jss6iwTL5RpiMEUmOBMJkDdj6
	CG1NAeTdL2fIvYJoDVFLlW+R0K315EYHNAkfhgxYjXuNuaeiTl0gAYY47qXqf0M+9R0w/6bWuay
	LYyMZPmdgWNWn0cfIF6Pexozqebhsm4uW9ndcfD9K3J/RUrWazeJlRFxpB9VO2hYbdTAox/sfxM
	/+XId6VVSqGMLY2MDSdintpfc+Fzqo1eYzJ8HiR/ua1+d1EoJdqyADV3oXClDk2n3X68atA/I=
X-Received: by 2002:a05:6000:186b:b0:487:81c:b5e2 with SMTP id ffacd0b85a97d-4871e244c0cmr2606562f8f.5.1789725329175;
        Fri, 18 Sep 2026 02:55:29 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff3a928sm3077528f8f.13.2026.09.18.02.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:55:28 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	mbrugger@suse.com,
	Sean Young <sean@mess.org>,
	Julian Braha <julianbraha@gmail.com>,
	"Gary Guo" <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v9 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
Date: Fri, 18 Sep 2026 11:59:02 +0200
Message-ID: <504b6c3403b0cdc1731d3dca735d5a07450e80e2.1789724999.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1789724999.git.andrea.porta@suse.com>
References: <cover.1789724999.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanimir Varbanov <svarbanov@suse.de>

The RP1 chipset used on the Raspberry Pi 5 features an integrated
PWM controller to drive the cooling fan.

Add the corresponding DT node for this PWM controller.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 12 ++++++++++++
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi     |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 0fc57e72632ed..748be8f1ee9e2 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -64,6 +64,12 @@ phy1: ethernet-phy@1 {
 };
 
 &rp1_gpio {
+	fan_pwm_default_state: fan-pwm-default-state {
+		function = "pwm1";
+		pins = "gpio45";
+		bias-pull-down;
+	};
+
 	usb_vbus_default_state: usb-vbus-default-state {
 		function = "vbus1";
 		groups = "vbus1";
@@ -94,6 +100,12 @@ &rp1_i2c6 {
 	pinctrl-names = "default";
 };
 
+&rp1_pwm1 {
+	pinctrl-0 = <&fan_pwm_default_state>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &rp1_usb0 {
 	pinctrl-0 = <&usb_vbus_default_state>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
index 16f5359395835..df4c2d09c8d34 100644
--- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -99,7 +99,16 @@ rp1_i2c6: i2c@40088000 {
 		clocks = <&rp1_clocks RP1_CLK_SYS>;
 		i2c-scl-rising-time-ns = <65>;
 		i2c-scl-falling-time-ns = <100>;
+		status = "disabled";
+	};
 
+	rp1_pwm1: pwm@4009c000 {
+		compatible = "raspberrypi,rp1-pwm";
+		reg = <0x00 0x4009c000  0x0 0x100>;
+		clocks = <&rp1_clocks RP1_CLK_PWM1>;
+		assigned-clocks = <&rp1_clocks RP1_CLK_PWM1>;
+		assigned-clock-rates = <50000000>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
-- 
2.35.3

