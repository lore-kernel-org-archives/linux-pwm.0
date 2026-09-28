Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB644DF4D7
	for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606358; cv=none; b=NCqwJyypz3dLfqamNPXFl8hfUlSBXwkqcOJRWG/Le1fdpRAjVgRt1tkb2wh0zjn7bdccJ9o98pe93a9e6x0cDELMFaRaQJ5qGnJq1R+Wu77YwYFn9zrwkAyBoHeeu7rcucwpg4vOAj6/7O/xqwwbKs2FKet00ehIabxgo5nLzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606358; c=relaxed/simple;
	bh=NyT3bvkYhBzVis/qc4NVpDUc0HxiHbXcgKHaKLAMasY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaRPak8X5UNO5pY7pJP0owbNU22AoBHGV6uuhf9kneJR2xILv22nbEcYFRXbeQbQMWN/Binu/Y8o73C2UJrstRuobJnNcTauIKDSSu3e8jYip9sXvBGgl3tvXzM5loHsU4yseANJxX7lHqKjBFJ/mqdMD+oXrsR5mXDxJN6MBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KqcgzHKD; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KqcgzHKD"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so17173945e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790606344; x=1791211144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=KqcgzHKDDBm/b4WJUjDIMt86FwR/CBXjhn4V6gRougf/o5w4tMuSWnYsSlKwC9YLLG
         T+EACmC0fv++9GNx83WPx70QTqOrlkIEPSEZLL8duyggTK+dVWXX70421xz+OPsMX2FN
         v+3uo1hbiLruvi08FwS8nGa/UDQuTpM90JL2v5JCELvJ2Q/mewUkCji1Sxigbfefr31G
         l916+y8ztW/uSayUkw8iaKpt/Mcwow6zHeEy1aJTM725yy/Hp0Y44dSeDkden5EkHodk
         mbSmO5XHBncqajlTUkUQTYbKJZEYD8pWfqmCZ2IbbWzx6e5SIGiPIFVgZeSrk4fkXjWv
         ptew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606344; x=1791211144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=m7PqOzCXIE9l4D+dAU8TRJIND96nZD3k6nL6pm9mdUaLY9P0zAm8KvOIP+HyLz9G+V
         nBbv3J8idslkM0rTxARf7ku7l6y+k60RDh4UPyRlcDrn7Wkmyg4YXSOjSjz8L/pR6DTp
         2+RZ7gWvDXydVllvs2qkth0SBnKUowDwaBCEXDzZDdDTlh1faWyV+Ppouq2VGxC+d/mQ
         rZVf2EkXqrP99cwWxgal2Q5zzBkUY3p428jcqIh9iPwlNWWW09oPRYEvzj3nE0+CUqC7
         +FCcP19YUlo/oc+f5XE/SC+Y2ZrXYY7yxsaI7OCBUZColcg7K5dj6MYECNbk4UXjMUuw
         Qebg==
X-Forwarded-Encrypted: i=1; AKwUvBxFdcF9leGiUNDpoTzSA8F96js94BRPYBsiFfTp7wsebOb4ZHMbBiWpbBN0SU99sw9L5i2a2GfTSiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kq937W0xA5SPIqf0V2cU9GO9wpAmI2bRSkLmFZiwAd3QVgf+xK
	OzjcSgeowqVyHm6STa7ZuD7oDtl4DA2E0U5D9AiyKCFGaTnRrbXjIMDk4QzvKLpxTVE=
X-Gm-Gg: AYBFou2MIVxwfSCF8pMSAFUDvsFZzwCpSkog3xIeOCnIcxO4ztpCg/KByIGpKNdpYhS
	Idb7pPEJ/RYTzDKVB3lUNO/xzoHlosTQDFUn0aeCJfBfhK20j1T5caYfw6OJfVLhyeI1rXJUZbs
	Ayf8MdbeAbKQCrizGmqMqPwjE2XZoh+fGcwcDaTGY1Id3uhMlawpekkpSgTlbH2LshZy33kv6W9
	8TEBNSpi72en1muHgq3BXmZ2dD7otp7k8Har0V1PCPlbAjzEngjqE67ylksviny23SK+Z+pSZ03
	idd/cVawJ8snVgUaABn5a1Da+NayEpibnuewOcSgcVO0G1xM0O4yfDOcLP5FvMYReewviB+Sg7w
	t0aRp48jdIHOmjvJK2GHZfZvstsukITjktz1b9aib4rO4SEzvB36Tc+jajDRzN74E0ud0iBm+iO
	fGizOnXviav3J1ODc92eKAxeMyojQ6RVDtkg0lM4WzxAqlf0cPDB52tpuZUbaWyYh7ZNeRKA==
X-Received: by 2002:a05:600c:8718:b0:49c:fc6c:be08 with SMTP id 5b1f17b1804b1-49ff06f8316mr163210765e9.31.1790606344550;
        Mon, 28 Sep 2026 07:39:04 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f0e79sm233409295e9.7.2026.09.28.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:39:04 -0700 (PDT)
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
Date: Mon, 28 Sep 2026 16:42:42 +0200
Message-ID: <ad9bc35d7c30f7925fed4c6621ed0f67c39c3f09.1790606188.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1790606188.git.andrea.porta@suse.com>
References: <cover.1790606188.git.andrea.porta@suse.com>
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

