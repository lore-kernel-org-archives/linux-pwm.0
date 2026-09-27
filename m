Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B83E5EF8;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519353; cv=none; b=EY+fqcta8OzmBipkhH2gyHZgtLMAyGUDFvI52qH2UEnxXIkHppaZ/1VItSQO8c5O/wOLGefRtQM4eKfJlBB4G5o1vRFrWnkJvk22JFB7xP0sCKXmMm5ngEWYbx3wgQpF/zCP3TWRQKvT0ztvL2qw/OImZo7uS6Si0uPWJaMhc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519353; c=relaxed/simple;
	bh=C204W/yB+PghlPEk0hny36BOqfLvlmVXE04baWTGylE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mD6+CWtljjG3cgzsVM+vvf6DoK3gSBTrhJnhedXhjvEnNI0LvWv9TKIzMW1bxyZkKmJ6Pz3A5paa8ewVJ2rZzOwQyPinht0wqlbUpvQi+1ET8pEDTvPCq6CMtV/tE3kfhXzVLdX5t+qqmB7PXdFgAZqG0A0nuTfIiuzeZLTlw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHFXhe0p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHFXhe0p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDB1FC4AF16;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790519352;
	bh=C204W/yB+PghlPEk0hny36BOqfLvlmVXE04baWTGylE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VHFXhe0pIkf44+OLRN2RfOr/mC7yAOH4TPymHU9o2Nd+1gTq75cl/C/F6qC/HJ93a
	 vZfh9m1d5EnG4Ji7Z8wrClscZGDEdjVASjAskQLkSVZ5dp/VguZMIQJJSaO7Ei44qC
	 tuH8QJDhva5NSvTj82lB2Tvj/MhbWX59z/mzrXLMUjWHbWUq5TiiJMpgXVzGJ4Hb2Z
	 3KeECwi2TPrCHRY0w7OWiNT0AdSrqVvUA38fkfg3B/jo46WIBBnJ9XpMv9uIhJFWDn
	 XQKTLoCVFQfvtDu30TY579GNCJ8AWPwuQ2hHAn5pTuhAPBviLkTr7dsrAuSYj09fEL
	 bIJndrtRxXaWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5780C9832F;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sun, 27 Sep 2026 16:28:16 +0200
Subject: [PATCH v3 2/3] pwm: meson: Add optional core clock for S4 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-add-t7-sys-pwm-clk-v3-2-18d66abea4d1@aliel.fr>
References: <20260927-add-t7-sys-pwm-clk-v3-0-18d66abea4d1@aliel.fr>
In-Reply-To: <20260927-add-t7-sys-pwm-clk-v3-0-18d66abea4d1@aliel.fr>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=38T10zBYHuRS2HPS8ZW7iUWdDAPvTmkAaZ2SgSI77jU=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9ZODa3lGz+sF/pdpSvCfHdB+5qmNToMZSlScyu3LbXbE
 hK1hflTRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjARmxBGhpcaOmHzJELMLu+U
 509/bCIwdeHJyrLTfE8i016tPvL+53VGhj2lfXL/1C+0hyTv/nUoX0uYycVwc6G2Cvvx3zs3Xe8
 5xwoA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

On some SoCs (e.g. T7), the PWM controller has a system clock that must
be enabled to access its registers, in addition to the per-channel
input clocks.

Get and enable it with devm_clk_get_optional_enabled() using the
"core" name. The clock is optional, so existing SoCs and device trees
that do not provide it keep working unchanged.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/pwm/pwm-meson.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 20e6cd07127c4..5ab07322e8d15 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -508,8 +508,13 @@ static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
 	struct device *dev = pwmchip_parent(chip);
 	struct device_node *np = dev->of_node;
 	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct clk *core_clk;
 	int i, ret;
 
+	core_clk = devm_clk_get_optional_enabled(dev, "core");
+	if (IS_ERR(core_clk))
+		return dev_err_probe(dev, PTR_ERR(core_clk), "Failed to get core clock\n");
+
 	for (i = 0; i < MESON_NUM_PWMS; i++) {
 		meson->channels[i].clk = of_clk_get(np, i);
 		if (IS_ERR(meson->channels[i].clk))

-- 
2.49.0


