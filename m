Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4283DDB09
	for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540450; cv=none; b=IklOko+APYX9EdfvQVYALZt9RZQRxQXOUEQUjXUjvPV0PeNIfr9j72bMqto2iKvvBsC9SK5oSfXWMoD1pJqQVaArGZnqOow1j8YXz/hubkzJ4l/sQt46cS8mhwSRF0OdIqiiDAo9gwmvV2GQ/9UX3iicTDsVNEFYC7I080k8tmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540450; c=relaxed/simple;
	bh=NyT3bvkYhBzVis/qc4NVpDUc0HxiHbXcgKHaKLAMasY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cW6cLZSkpSxXDWPtNGFwsTfJRetXSUVaaQMTComMsC70zVVN7Iv2p+5d6y6SoA4ttOmlGN0YSlxAVHz7VJUbk8WrBpgBh5xUp5u2K5YzdpX6jFrBsX8FMvr+xRVJJvYPWxVihpzlaCi2PAo8geNOych0JlKe5eHrafe7R0Uttyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gQ0GVw+9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gQ0GVw+9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f7854678cso274914f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784540447; x=1785145247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=gQ0GVw+9aeiCLEc/xn7mjbxpXod6nRbcnq30cKc33EplLBIKQj4qDjbifW5hxN0/e/
         hbSh3ZXLxggW8GdkgwvIfT5ckWZ4UKph5fj/JfWRh+zLEGuSYtgbf5WFyxLOB87k3n03
         JKNNMo87n0Gjeburunx0rr8fvZuFicbeh5i2gCBR59cgs6ijKENejCh4vWongWwnPaM0
         l09FdMAGGKk9jt4pyILf/dpW7D9sKuiBt7NKRmibrSNc738ulyrtwERz336fvqFKo1Ox
         XVRoq5CcvGc5cNsaPaNDlVBl0bUNvQxAQs+ujt8h8KK9V3vBWxEP1WFVVstjeQfYMq8X
         coUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784540447; x=1785145247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=J1ibMBAyk+7Kq+pftiHyMxi/uzLFbX6QXbrS5yFh42mX21VLqetr+6EpavNKTdZwvd
         aItvVcezGDLXGsnMaM/BfZsmIMUsnnvNCLyncby2+LZc+Pp9IZIY9gR75p11/eWwPfiK
         JQIZRZoIIWcj1h3/Rd20FfpsMYYeHsEKSvlF9NuihrcCFfK3ostBIer5CjJMvSchEoxm
         MOF57bIE7zA5yTWkHcW0gWo+qJGghiAYpxX/UpnuFa8A/r1lBcFikCgO9CeEA2k+LRB/
         cPKif9JWMSwuJ5icVv3AmZYEURNV/3e+yzzrp6MJR6r77PHFFYx2nGHYcJN8KRTCJ/Ev
         rQRA==
X-Forwarded-Encrypted: i=1; AHgh+RrbTjFT5n+YWwttw5L/QNeC1PI8Jzq1gnrq/oPD/TBIY+TZ56YotzW6VseYSjvzsQx98DDxcev+4uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5EqYuaxSB52TWRV6+5PgjShMuLrJFpcLSzaAGb7NS26rqRma
	s8FRyVCVp+MpOj4y4sFmQpuVlHLl2lbXF+VrspWpRQriOZd+QoOz51Uud2N3/Mj2U4Y=
X-Gm-Gg: AR+sD11zuWHCit+vMtyIG0f5T8vWEyTNQdnS82NyATm3oJ5EWCbmp0FrsMc3TZN2Sri
	Rw7TyXWFNT90ai71PvpoeNpJZGzztWa11T8yZKgqFkTOpgGtJZsdpy+F8bbnodRjllHy1kQ1tuc
	oBnqGykdOHmBXoW7GdcmzdkvE/rTwdNQ7hg6NCp/qKFH0DYCQXR/DTT39k045ujfho8d0lGwEr+
	7EFrbYybBpG1fqGpy/WeUercMMKuErFaiCYNygfGZb7Q76mmQD9+PqdIDJrpF2uvKaa2vNytpk0
	n3r4FpvFJO0IRKmCPjvdvEPS+pumZo5OdUXHntgFgG7rCp03KEd07jxQkDE8fRd+aDtUkjkWGlg
	KUHaAv/DSxS39jOOqPon1fCubH/7Q4VMtY5Xl5Manhv9Z7L1zkonyUfCH6T1R697ppyVth9Ag+t
	H6Ve9iBcr9ock=
X-Received: by 2002:a5d:64c6:0:b0:47f:7a15:dc4 with SMTP id ffacd0b85a97d-47f7a150fb1mr2150322f8f.23.1784540446582;
        Mon, 20 Jul 2026 02:40:46 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eea8afsm29707819f8f.33.2026.07.20.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:40:46 -0700 (PDT)
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
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v7 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
Date: Mon, 20 Jul 2026 11:44:07 +0200
Message-ID: <895152a8a7b541279519392b5e7983a861a7bd13.1784539788.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784539788.git.andrea.porta@suse.com>
References: <cover.1784539788.git.andrea.porta@suse.com>
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

