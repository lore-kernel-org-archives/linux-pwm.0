Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78BF4D5970
	for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603735; cv=none; b=ff6wfZIYVulKxpJJn8Id6Q0b7nHfv9tc41DE8ZOVNB56Z3l4ftTIajphXwm+EKX5SaGaDq2jwAhKCtOWtKl9IRuvpRRt5vAwgK8Edrh+SB2+POOcsth5hTiFmrUgF6EjCznvvwUBABFtCJSP97koq8VHcknQ6/IkAr5P4vyDRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603735; c=relaxed/simple;
	bh=NyT3bvkYhBzVis/qc4NVpDUc0HxiHbXcgKHaKLAMasY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOYzcVnXZymrIIFinf8CuUcKAz6Vsyd6xDvSjJ+JY+ermSmn+RvPkYUgjhsh/ew6l0fpCdsdV69GVkfXwcJmZHIH6+3uxoNxMlzRr3o805mwNzFUT2Q8o7OE3cC0FWKvciqt5DA4hB2Ub0/W1bMp0B4u/GSKQYq9UEZqDR2g5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DJE7fgVZ; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DJE7fgVZ"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af7721e4aso384132166b.1
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790603732; x=1791208532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=DJE7fgVZC+gNP4wYfKUU5byTvBHa4FaOGoBxDrOHA6Nk2V4uxuX9LejhpmRIRd/84p
         BYXUiu/7Ttfmu6rmOhh/bMnh0pPlyFTxI8RZS+V+RFpUzBLIS9YfnHnWLI3LAJs0NNmL
         bF99C9g5ngl4ilu18pZkDx5HRPvev5C4ASEj7fQMqFl/qqQSdgiyDg7QNDE6RmKy2Ixa
         HoJTBVGNpoCT8AEQenFpnIp/dcjRDN11q8XR+iUSS9ZrvcLk6PMS4n+ldUFCo32kcZh/
         n7OZNBlMOAztqWxNuY3kiHuWbM6VHpTw/gq1+99GRwOl5ud/hjLBIsZYhyzbn7An5PH3
         Ttnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603732; x=1791208532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=JiUchIUpouhDaBLKeySnglo2FlPW64QkjA0+rDz3JeF1ICbj3fMhy+lRLG0W9nume7
         7bTnf6WDh1oPxwyyhZce2/jIQ93ou6o8ny88ioSw1AuDfHO3EW91BXTWwHjfIAcd6RdK
         qJnm1M7iH/5rO6D9TtDF6jMsPP5gFabE6PG7eDk7iPPAC+jSRjh6/zqRoT10F5OuFVqx
         1rajQyI8rmTbZK8j7Crj96j2SYD+YvcwPekjxjkL1zCI42wDP78GxMbQ9KotxCABMnUH
         n+jPsRGu0eX6CicZZFGnuPXunO64RLZU7+8Fo78LeWDThXVdinsifbrozPZyzbQTfc9m
         Rkhg==
X-Forwarded-Encrypted: i=1; AKwUvByu5371Afv+Pxt0tquoJlB8kEDI24qEPdoqwoRMO9e8vU44hAr0Tr7H7nuNxG6gFmyhM4WiRrUFQiw=@vger.kernel.org
X-Gm-Message-State: AFuF++krYgHe09NU62q+kcpNcn7nlAtjqDexUelXqBuYWDnooLpkM9TM
	yD6bhITC8WoQ/3MaKlQIgIcUM57etavUpA8vhuOFArajSggpJAYDwiM0NKUylMVT5OE=
X-Gm-Gg: AYBFou0efhGwirG0n8sUECyIX2f4NEiwxM0okKs/Xy/K2XHn2KgTaVdtrF+hEnTMqCM
	gJqykwQQThdbDUazSCsmOoNqqtyRp2iQqGjJVBmNfmYP/VtyO1FxN6gG1L5UhuSie7wRz1pVCJR
	8iLzN2UGGE63BBPUlP0FPSh+vnlDzhGI6laj7ULUEQQ5KNXaGdO2Ry92tWmkeaCRW74K1hFUpvY
	Q1cQYtVKsp121CJx1yatypOYf1hk7ZWK/g3C4/gOqGqKSwYMjDVFFVpvHtSgynuwDzpLvGE06XA
	j+V0M4L6/cU/q7lrugMvXybLb9b7cpiRPD8hVuQbBctyfUCG8DYK2cRic7BQn1lMGCPsmbEPMYV
	oJTqD77YiQvCzviCEbVa1H0QLJGiv1sJSnQmWn8b1IB8sQhFrDzfedIa0bXxVTavZ12CvmWE2YQ
	ZXV+699Pn9D04CZKwqTnvHs+x/R5Ah8G9oy6EXWsTNAHwOUpXP+pOOFtGq6sFtCFy2CLaeOA==
X-Received: by 2002:a17:906:730d:b0:c29:4b79:e417 with SMTP id a640c23a62f3a-c2ac240e791mr1124305166b.16.1790603731805;
        Mon, 28 Sep 2026 06:55:31 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc9a855adsm232416866b.60.2026.09.28.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:55:30 -0700 (PDT)
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
Subject: [PATCH v10 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
Date: Mon, 28 Sep 2026 15:59:02 +0200
Message-ID: <b222c0aa1c77564090d3c783cc79baf299b5d59b.1790603500.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1790603500.git.andrea.porta@suse.com>
References: <cover.1790603500.git.andrea.porta@suse.com>
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

