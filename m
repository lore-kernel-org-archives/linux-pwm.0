Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5549BD98
	for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049821; cv=none; b=NfZqvv2z00EfMuhZqsjhn4Og2bPmN6DGjLPuSDVid9WxjBk6Cwb0DhbzeG8PYRVXr3qx/QjHCTpQ0McvUVjXc4Pu0kq2FAIIgvGQVU2eR8/RsrEoMm7hJdF0lk0TaBuvFGtAw+b2ztNWdwlpeYMglDdwyL+1sbIEJofCfs0AOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049821; c=relaxed/simple;
	bh=xA45Y61XTBAgpBy6OAEVUm+aoRID/iBFxEHp4Q6aM/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dX5G1W95JwOQpMoH0Xva/xQ2oUVvoBIn8n8DXtMvTc7hPJoJDxKdaL8COPtKZiUjk6Sj7ANwp3oPc+F0eDZQxWCQaTeQ5kvQXQJINqyH/Ensmi2sZCYSZRVFDQVSsRgCoau/ZKThbZrz9fZZmoVv60CMuQ11X8z1k0x1sfgqqMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ9clEgS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ9clEgS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso103364805e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789049816; x=1789654616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5WKuPMePtnop5uPfXFl1ahyGCh0WOUAD5jTxVfDVb9I=;
        b=lQ9clEgS3Tw6dpdrUNTsv5JC6Pv6Mvk1nNq1+006g7fVDdjBRc9cF6cNuJpQYuJoLl
         rsSoRZbq8pwaV9OLBVFVWFcpKIIlHlhUeabZaTRxbyBpw7bEx0wVcdFk7Xbb/g/1FT3N
         tt3VK4Pps6RhuxY+6CfCO1mKKkMhQ1YwDRJ+/MbYaa0sM+jzi3rhP85Ksy8IlsE+Fq5f
         CI4e/dE8B0UkoC8hrq3QiCc/nQTsgjn7Y7bKH+yphaUuRPRTHtXZhKfl0oitdsGRrECb
         /5b3fFheIcitWvRzGSxrP421yH48vIuNZAHXTdyoTNti0MlyJpbMuxw1RUqBpPgpUdkq
         y4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049816; x=1789654616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5WKuPMePtnop5uPfXFl1ahyGCh0WOUAD5jTxVfDVb9I=;
        b=NB/NKpMZmZSapksWblDQP6DCgQ9FKDkPpuF6JBlvBDuYNfzfRICBS+vy930o/+3ScQ
         bO8sA6StT646BmjlPLxMR4LjPa0t1Uttm/A4UbAyXK7DbULICxt772J3qb23zd0Elikv
         WfvSitdOSR8Oikq+VpCeE32bnXF3aw7KCFopYbA3mkTdFQYMiqKhh29hFgFM6s+03cyM
         fyoCLYWKHU81YW6oGLwthR3psPnOOhBeVRhLBuxPTSsXuoehBoz2EJWmqderopCW00qJ
         6R25AdFvO368Yz2LjLa4GGwsin3VC6XmLrzaUQU7I4hk4uxnBrVdp/vvmd63c+LlEyPn
         OM9Q==
X-Forwarded-Encrypted: i=1; AKwUvBw467EMqAaqg6n1Hl1l7FljRkaZ6di/zJiRy9cTLzMrB/66KBqelBAoWiIuusEPAhn70yAxAUoSU/A=@vger.kernel.org
X-Gm-Message-State: AFuF++nShDoNBppoTayRNQkmZQYRnZL0kHOaaeUKRHsMpnAZoMtmmXKO
	zO03rxTF0fWScsgiksR7eIcn+qfWCdPM674AKU1H7Z+k+C/S0zQqp+Ii
X-Gm-Gg: AYBFou08Y0e78otm0L+jCsC1IQ8bjERqq4BWB9yOiU5NTaHF3YZcwsTLM1NZ+GF5xGP
	FLKHVEbxAE5zgWrVY3HluKc0tQTCaB+e7X3fmoHS0pWWZ7t3SfJyVWbVpWMrY2kkkYoU7gPm/Nh
	eLZj50xY/cnpUZaPXliR0/KjYPoTpqE0N6k1EahS/tiksWgPw/iupTmt+zGcOsqz9wh3D4fxyq4
	D25ozvbqv2BhnwwvFwyzFfzxAlscY7/fPfWt25kuDcZOjK4BZOzJSvNsSYM7Zbdkw483xDFDfoY
	+qrQ2Hd+8d264FAYBEwW890jus0vfN/Zcd2dycWx2luZyaHUTLB7adHcsQUnQFXlRE6Tm2mW3RU
	PIggUK2RDBWP1vhBtHBx4WASzKdctfYrLjYEUDRN3YdMp12NkXqmKbK67o7/xrMGgHSv52hbOrT
	MFNALK7gZ5S5PrYxp1W84yj8XCWm5p6riYm/dU3hsBHtMC64ZsiYSlQ1jAR9GP30K3a1dAj3QsA
	pjKgt0eq4oMK7zbsjVJioHxzDUkNqSr5hfVgzyo6DDYgLmiFmepmOfQM49SpxNjoHYwnuYkWQ==
X-Received: by 2002:a05:600c:c168:b0:49c:edfa:15a with SMTP id 5b1f17b1804b1-49cf826c5f5mr415258855e9.13.1789049816022;
        Thu, 10 Sep 2026 07:16:56 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm293895575e9.4.2026.09.10.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:16:55 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Thu, 10 Sep 2026 16:16:46 +0200
Subject: [PATCH v2 5/7] of: unittest: Test fw_devlink with PWM nexus maps
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-fw-devlink-nexus-ready-v2-5-17ac82dbe226@toradex.com>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
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
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, 
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
 drivers/of/unittest-data/tests-phandle.dtsi | 16 ++++++++++++++++
 drivers/of/unittest.c                       |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index c3727ed15bde..eef966615b22 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -85,11 +85,19 @@ gpio_provider: gpio-controller {
 					#gpio-cells = <2>;
 				};
 
+				pwm_provider: pwm-controller {
+					#pwm-cells = <2>;
+				};
+
 				fwdevlink_nexus: nexus {
 					#gpio-cells = <2>;
+					#pwm-cells = <2>;
 					gpio-map = <0 0 &gpio_provider 1 0>;
 					gpio-map-mask = <0xffffffff 0>;
 					gpio-map-pass-thru = <0 0xffffffff>;
+					pwm-map = <0 0 &pwm_provider 1 0>;
+					pwm-map-mask = <0xffffffff 0>;
+					pwm-map-pass-thru = <0 0xffffffff>;
 				};
 
 				gpio-compat-consumer {
@@ -111,6 +119,14 @@ gpio-direct-consumer {
 				gpio-singular-consumer {
 					test-gpio = <&fwdevlink_nexus 0 0>;
 				};
+
+				pwm-consumer {
+					pwms = <&fwdevlink_nexus 0 0>;
+				};
+
+				pwm-direct-consumer {
+					pwms = <&pwm_provider 1 0>;
+				};
 			};
 		};
 	};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index dfa3c885d142..b739a69997a9 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -770,6 +770,8 @@ static void __init of_unittest_fw_devlink(void)
 		{ "gpio-consumer", "gpio-controller" },
 		{ "gpio-direct-consumer", "gpio-controller" },
 		{ "gpio-singular-consumer", "gpio-controller" },
+		{ "pwm-consumer", "pwm-controller" },
+		{ "pwm-direct-consumer", "pwm-controller" },
 	};
 	struct device_node *tests;
 	int i;

-- 
2.43.0

