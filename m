Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F03EDAB5;
	Thu, 27 Aug 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820047; cv=none; b=SstRimWOXYhu8VQiIMzmK5JLEBHFB54TsiF83wbAL8vjqmpCDhTvGCYBO/TwCFquESExZ2THXLh1QcIlZAGEfV7XiaUeSM7xOGZ5xij58SOTbOJo5YaqTVFtoozTibB6ZkeaGAtVKB12i23bufcPgtLm1wXyMVOsG32oFZ7r8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820047; c=relaxed/simple;
	bh=raey7IcSkGHwiWP9oHD9SowA1rYRlgfNL/m5FNUAnww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEy78WyzJCweo/92U6qQjAw71UnUlMH6584JHPdo9IVq6gobCR2fUmQ5/zUvv7ZAWYtY6Rg34RJWF33qZCdP1Bl0Ov22QSFd/uNGZqsP1SNbOwnyUe2HOIPuOsVISigpH10dD6b/qSneXncvKbL0OF6ha/wvUZAld9qpwA7Hh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVnXVStM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVnXVStM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA36DC2BCFC;
	Thu, 27 Aug 2026 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787820046;
	bh=raey7IcSkGHwiWP9oHD9SowA1rYRlgfNL/m5FNUAnww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PVnXVStMqKiADJZK4H5/iy0nEtYMV/mZgjz/i0AisjNSUdLDtpMzafZInmIUAJF8H
	 TFUdwUjGwcihgVkD7fxH77C7ibwd9uIqiSxUxrHvqHQrdl2/qPRwQpoPjuXpmB26pH
	 gnO+39rYFMmXpULHIS2hRrt7YGwpg4YbYscss4tGve5d8rYmUzoI/9Dh5oKZ8HKf/J
	 GbeMvwkfscRfVQNljge0kzlpEnr+zVNXGUE1UhnqWKTabHXoTobt8t0PZLdVCJt2tr
	 rEt8HW10F4MU8PcPCL2BPzg2xib2D1bP6PhtgVKZT7fWnw2GFypJvetogebx6YFuce
	 2FjlFDy1h+JsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B31C61DCB;
	Thu, 27 Aug 2026 08:40:46 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 27 Aug 2026 08:40:13 +0000
Subject: [PATCH v4 4/4] pwm: meson: Add support for Amlogic S7
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-s6-s7-pwm-v4-4-d28a2015177d@amlogic.com>
References: <20260827-s6-s7-pwm-v4-0-d28a2015177d@amlogic.com>
In-Reply-To: <20260827-s6-s7-pwm-v4-0-d28a2015177d@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787820043; l=1273;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=bxanl4T1hd21Hw06PnQXj6xGMQbU+zReu1OrHg7McSk=;
 b=0vaQo/fBgbLRHzWKS3mXgLiyVajPMUz9dbrbZVd3jjmB/2F56tL5Ry9j/ENdIlQL/PLCowQAm
 P2g2nAg4w+RBIldLTwsxHkfgwYiA7ukj3SBodgsTJ8I/HNKY0pwBTxL
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add support for Amlogic S7 PWM. Amlogic S7 different from the previous
SoCs, a controller includes one pwm, at the same time,the controller has
only one input clock source.

Also use the kernel coding style for the empty of_device_id terminator.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/pwm/pwm-meson.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 6f151464d7cc..2da958231719 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -595,6 +595,13 @@ static const struct meson_pwm_data pwm_s4_data = {
 	.npwm = 2,
 };
 
+static const struct meson_pwm_data pwm_s7_data = {
+	.channels_init = meson_pwm_init_channels_per_channel_clk,
+	.has_constant = true,
+	.has_polarity = true,
+	.npwm = 1,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
@@ -645,7 +652,11 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-s4-pwm",
 		.data = &pwm_s4_data
 	},
-	{},
+	{
+		.compatible = "amlogic,s7-pwm",
+		.data = &pwm_s7_data
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 

-- 
2.52.0


