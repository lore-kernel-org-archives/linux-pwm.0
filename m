Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501229;
	b=3VPsQqaAG/XLPp2WU1txe5jKOcyKHMp1jskr2hUZIzu05svFDeGQmuyMvzSWGkOzhKJc
	 wRqt8tirZfJ20mj1jJno4p/M9CJxgM7DXB4luUUqsKjmMwIMRow52f+3OKbDgUDAjRGg/
	 IJAJYYX3dfYWmBW/PeqDDxE8D7H6s9ljn4FY/tcEWCBIm68zYC9/S3T2ObLI6d36CbdeG
	 CVlpodyDZ75TaRTWrc/B1fl3Zhew6/O+kpS0P5PqUU/m10fgQaB2RrtLdopv8OkMw9/0A
	 oPoegKfjaYffK7ZqdxGQN2lo1ov8E+Psgqs1K4Czj8xR1FEDteQk8PngnfMry6sqHTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ThcckzMwPNlQzjyX8+RLOp31Su+73AzB9RfMA4Z1d2Q=;
	b=VW8UOXbqMsF6A1rdwLVLHcyS3ZrdDJf3nvwqnPe3EHoFDjsCamolsZubWq2YUpnCueeC
	 kkQbmhdJYJPZbyS0+7KOERqrjRl5Jl41csfT0ahC+iFoO+tV1iLScyemM50l1wA/cndxK
	 uVAwipBd2vjU6NKf7D0y0RvHIMtRU8hM9V55b0GnWa/XvtgJDp1PChhDX1xFmdZi3XGM7
	 JHe4JUCNvdLEu8r11RsDJ/W2OYP08IQAsFrL+jWpv4EFmn1K1AmzBncGpaqPRJEGXwMKp
	 cjFTlkymWiWrkkLP5B3LgTra3hR0y2ekZrcNkX2XuOz0XB542C7TpITvE87XBCMVh0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bkPIlHVk;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4E60A4AD3
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 13:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F4E60A4AD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bkPIlHVk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1e2957d7eso22662085e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501226; x=1793106026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ThcckzMwPNlQzjyX8+RLOp31Su+73AzB9RfMA4Z1d2Q=;
        b=bkPIlHVkl2+6DyV+bms3fSk0DUfaEBzatJ2hLyXeVQ6lKCBHOkuXcyYp2ucasQV7Y6
         Bzktlgjsblk+BT4Ms8druX1pFOKQE3DjybW8t7BeTCoZMIRHkrCGr4t/AdyRfIb6VFic
         +4CyCGDl5Ta9QPiLfoJHk0EALsoeuo1kuuua0HCYtIJMqR92YGEsJsjKnlqTAPIheXo+
         2I5c596M8g2SjCgjuH9KoREHp6KRO7jhmZnYPC90YCz2cr3KAsnMqyCge2ecpPMZszVO
         hVFKSV0IefGdfXTM9Bt3w1kMdXB7p0rS5qSP655OOQwtXGTDhfdp9EKuG9g2hPbBYlCP
         at5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501226; x=1793106026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThcckzMwPNlQzjyX8+RLOp31Su+73AzB9RfMA4Z1d2Q=;
        b=J3r8j+UWha2aWEUIYCqO3AveYKEmqN7e9W5/JS/U/b3ki1lwm3e5aEWMcvpO4gfOJu
         9OTJWDQOVmM5oFG1J0JML9OMWJQTIA9e0cDVjw/Kc0pXIbruvDbNCzk4/b4yIPp7VbfB
         Ob8ZtNIfcqFLi/exaVOM341keCUuNNWZweFnA68QSxavVkM6TyBNWjN7JOh3wnq3QVjE
         H2ALZ1BCOnHDNL2kRdle+CoLqkOfPOWEh7Wf2iu5++y42agXCvGOC2eSXx7ZEAwDnH9b
         NdmTFWtBCaAEYKKVvOlZutsgvuxyXjdcwZBSy7RGKIJ098xpqCyZw62Q+9s87LLKBqNv
         S6qg==
X-Forwarded-Encrypted: i=1; AKwUvBzsaRhVsKNyIBktrgB7oMmnRmZSbL7dygDXNUjSimfDXcW8uourCqZZXxjaxsMgtwthEMnr7s2rmno=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf3B2/bokIdmjz+E+i9wd+Zifi7yAmZklL9dGNdwO60HOJdHwP
	NkKObFzA5PkiXKk80wOcMRbi16akEXas4bS6tpy8HfWg0pz5r4AaovZeLXSzFpOAW4uO7w==
X-Gm-Gg: AYBFou122SzrecjetmQuAimVxpkhIokJS5EEcRI5Iv9Fb928cANJxAfsYNrKk9XkOb+
	Ho0Yd767hMBDLj+0dp94zrR8QfydY+LtFqfGbhKYtMmdZyqHLfUL6iyHDNP+mECu8YwW11Wit6K
	T6cYCp4//d361FdOOQvLpjzGTL1exFztMp+Qp3rFaqE1rAzgDxEm8S4w3Uej36CXvd7vD5bZ0FK
	se6ul2h0WTtBy6Pw91M12is+iaISoKVTYZNmbzCVdZdmWkuSOQS7kh9aoU86pEJNBnJz563z2Uk
	TsOcdcUtF0XAo/4OpMxekv31wwi2shbYF2kkwYZU8Gyxg5P4dYgjFUUQGkG+d4avuFfQ3jJj9lt
	qSs048WNB0MP3f+BOZW93WS1Gwzb6p+yGFi9OAnBv15pR40L23wITIrnWJHaI12WZtUC4LXtlcQ
	JJ+gCj6gI2gEyrQM1iqu1L39gbQlql1xT1roLnh9HUD/frZTDd5JuuliJ75HM9fahx0D6Y5yhsm
	Kts3n5T4+dA8hdihZgiVqQzTWJfrBxtDE31CVuSuax0gYkVVWVMc60hbRIGbZYSD7jEnMphhwem
	vWukqGCpqQ==
X-Received: by 2002:a05:600c:6298:b0:4a1:96cd:2f60 with SMTP id 5b1f17b1804b1-4a1d75ce285mr218735335e9.3.1792501226292;
        Tue, 20 Oct 2026 06:00:26 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm6114754f8f.54.2026.10.20.06.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:00:25 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 20 Oct 2026 15:00:17 +0200
Subject: [PATCH v3 6/8] of: unittest: Test fw_devlink with PWM nexus maps
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
Message-Id: <20261020-fw-devlink-nexus-ready-v3-6-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.li@oss.nxp.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Leonardo Costa <leonardo.costa@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Extend the fw_devlink OF unit tests with PWM references routed through a
nexus map. Verify that the mapped consumer has exactly one link to the
final PWM provider rather than to the nexus.

Also cover a direct PWM reference to ensure that it continues to resolve
to the original provider when no map is present.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
v3: Route pwm-map entries to two providers, use a middle entry (Herve)
v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v2-5-17ac82dbe226@toradex.com
---
 drivers/of/unittest-data/tests-phandle.dtsi | 22 ++++++++++++++++++++++
 drivers/of/unittest.c                       |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index f5d7ee072c90..1fd465bb8f79 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -89,13 +89,27 @@ gpio_provider_b: gpio-controller-b {
 					#gpio-cells = <2>;
 				};
 
+				pwm_provider_a: pwm-controller-a {
+					#pwm-cells = <2>;
+				};
+
+				pwm_provider_b: pwm-controller-b {
+					#pwm-cells = <2>;
+				};
+
 				fwdevlink_nexus: nexus {
 					#gpio-cells = <2>;
+					#pwm-cells = <2>;
 					gpio-map = <1 0 &gpio_provider_a 3 0>,
 						   <2 0 &gpio_provider_b 5 0>,
 						   <3 0 &gpio_provider_a 7 0>;
 					gpio-map-mask = <0xffffffff 0>;
 					gpio-map-pass-thru = <0 0xffffffff>;
+					pwm-map = <1 0 &pwm_provider_a 3 0>,
+						  <2 0 &pwm_provider_b 5 0>,
+						  <3 0 &pwm_provider_a 7 0>;
+					pwm-map-mask = <0xffffffff 0>;
+					pwm-map-pass-thru = <0 0xffffffff>;
 				};
 
 				gpio-compat-consumer {
@@ -117,6 +131,14 @@ gpio-direct-consumer {
 				gpio-singular-consumer {
 					test-gpio = <&fwdevlink_nexus 2 1>;
 				};
+
+				pwm-consumer {
+					pwms = <&fwdevlink_nexus 2 1000>;
+				};
+
+				pwm-direct-consumer {
+					pwms = <&pwm_provider_a 1 0>;
+				};
 			};
 		};
 	};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f15c110dbf4d..320a992c4310 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -770,6 +770,8 @@ static void __init of_unittest_fw_devlink(void)
 		{ "gpio-consumer", "gpio-controller-b" },
 		{ "gpio-direct-consumer", "gpio-controller-a" },
 		{ "gpio-singular-consumer", "gpio-controller-b" },
+		{ "pwm-consumer", "pwm-controller-b" },
+		{ "pwm-direct-consumer", "pwm-controller-a" },
 	};
 	struct device_node *tests;
 	int i;

-- 
2.43.0

