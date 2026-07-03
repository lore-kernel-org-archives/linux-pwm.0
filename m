Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5930C160
	for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2026 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098132; cv=none; b=slPHYuhoG2c9S2aRNjNsJ5pd5vdA5nRoi0K6kt7eQbSUzVitW3QIotE3WL6DuZlmoQyx2PIO5SlCY0LRVxBfEZ3OWABWLrnKPdO6776DWm/Lh7/20dZlisovDdo1TCh1znmeaSAKfpttrx5O4oIpGb5AbDB4c0H7qkxWXoUkdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098132; c=relaxed/simple;
	bh=NyT3bvkYhBzVis/qc4NVpDUc0HxiHbXcgKHaKLAMasY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHocyyAYFSHifcrjAAEhCLFMzgpRePEo1AbsyIt9ix8xKblqJV/BfhS5xwTctIiY0VK4tCNbZkYIPg3Ihyhwh/UyQVOskPQwJA2n49CftlAJsIrOU89e7YqxiXDGHRCyKMZ+NfG7JhoSZ6yBY/0ayzfMplcARoUn7L+B9rLjq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SrIT9wos; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SrIT9wos"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so4256825e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jul 2026 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783098129; x=1783702929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=SrIT9woscH72pWMFOd2U7HIlNZGqY9utg3/f0SLrqxePz2tAIqPZ5Be1TwmVrNcKb4
         QRJyf5Bw/rsY3OeZbZ/AhgqLQ4d/I6DIaDVzHGciHFwfgWwGg2hxCz0zCGNG2Pc1ZLYy
         OR8tPoYyekzvHjhf5TR8CEy5jbqf7ZK3I9on6z02f0Bn/69updId2LdYpti2wFMJ/heV
         WM3nmvje+QQ0dUQy9W03RvMsk3NC6rPFCaTXY/5LWRAUuANsCnWYIw9YylQd09jZMWr0
         ABvne6NlypDWDj6jBhf+vTSZqj6JkmE5u9dwOHXppVOJ3E1ELMnpOIXSdPLEuDLD+B52
         YWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783098129; x=1783702929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=qwspZz2xlmHFhzmWGKG0pvS3VA+J48PCcKS5pqAevwmMRRz9/EViK5XsltthE+r+D0
         AWA/MOweRJQJass04dGNqhrA7CQMvubaXWYXj75TslMqh9b9kxU85DXFl1Z4i3+lx/5t
         8QdOafby4P1OeD1u+kydBsi04Nc+3gYs0JqMoldnhkARsxfuX96OquxSVRFXX76zpU+u
         cV+YVf9QkYekHf7ehkZb5paoEouDSqWSYkLkAoJF5hrT2hnqJwHhWtsDj/SljwAwBgIG
         WfpKGsCkrefqaHlSelFzHQ9nZom65d6kYGEIIM2J8kgSagKPgUoR1YFd85igGYUKweeN
         SoaA==
X-Forwarded-Encrypted: i=1; AFNElJ+jxEhoLeStv+FpXuv/w3xT4iD8M1CSOrhtZW1Jb/A0PxkJlIicHAixKgng78wDtKH95ArUvWlYSsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlThvH/pes7qpe4BElQEZDPORP8A9LpNdmboRIJPXDkSCQLsJn
	B80oJKkoXWQAblBq2DqtAceIKj340V1+1cQ/NVEMNe72pS/S4XEd6eLxe7gk+krrBzE=
X-Gm-Gg: AfdE7ck1lVH9/x2W++xaL897uAQL8wI5Wz1GfBJWZeesO1J875AEBiXznm8mV+PFbNn
	TZKkvAqOIfRQXTvvLEzqEYltApClILTnAIjpaNzpAJfl8TKlLkYsJ85eHLMFwJ2Sup3Qrmw/7pN
	fvPyOxKSJn4ZtZLKZGzVQaz5kwcEAhxv0QsAjjEEZWa6/YBv8GqC0VPKaLhzlKeGQI0xSImT1O3
	m4nS14wah6JVFWHlFfkl4gYskT3vZKbKFZyZGFTWJl5wrQ1sTMwObu+7CQPlrMzSEwFMdOWsv1k
	D4sRhjBcgmwBWpOlo1+euDJREmXX8JoHvAlmrFZC8B0T80VlWwMm/mL5tzMtHG6RW0UgbJP98Ff
	8Vu06h6OogTC5JxVtO8634t6seGvM86Pu9WI4jUEDVnKI6qzsdX0cTMYJG7meFN6JhrS6YmoDaq
	lOrP2lnSTgUwE=
X-Received: by 2002:a05:600c:358b:b0:492:3da4:81ef with SMTP id 5b1f17b1804b1-493d11f13d7mr1621605e9.18.1783098129262;
        Fri, 03 Jul 2026 10:02:09 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63ba971sm225754325e9.13.2026.07.03.10.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:02:08 -0700 (PDT)
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
Subject: [PATCH v6 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
Date: Fri,  3 Jul 2026 19:05:26 +0200
Message-ID: <300b6fb4ba2c9399297b4bd85cbb3bc14f08f6b7.1783097764.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1783097764.git.andrea.porta@suse.com>
References: <cover.1783097764.git.andrea.porta@suse.com>
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

