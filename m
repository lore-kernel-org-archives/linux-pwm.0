Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27B3DA7C0;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873788; cv=none; b=DJJXqxAgUrTCu9v5P/bDx6epIwLhMPb6UcJqPT8pHLTpTZEO56ydgjuTUJgs+HYmE7xGLy0qyWV6gSLMb8WOiy39e7+lVimn0K07ckLfK85x9In11OhP8Yfnyt2zaOCmmgg0sXPgQMebEqzGDvXpBsGgRKhGj63qZwjsPpfNKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873788; c=relaxed/simple;
	bh=U6Axf79ZpyUkwq9Xo/HqsSHd8GDH7dGjJ/q6N5e0mvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OikfYDXWRjM0xuOEILAorNirggPXTLlZjX56eTvXg5dMNb5lP/li4O+5ZWAjjcFKuV6QKhpSY3dAGiwg6Fnqs4/Y5VXXhAJkkX5dJBSRcAa2/DagfzgTFmgisO23gjXINdA5uypN2AXoAOPuevYvnsytWLHsqRar4OkvLfB0CAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ikCzJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ikCzJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70899C2BCF4;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790873788;
	bh=U6Axf79ZpyUkwq9Xo/HqsSHd8GDH7dGjJ/q6N5e0mvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C/ikCzJ1vBb1OBqj9qNUwaYvx1dMvtAvS6Ic3dd7fVjgBc6IlOMVGeQl4GS4tUDnf
	 FSpzYSQJANY3TtQKbcvqAZzd7CZVZH3+EDvhGx8PzeyqYDP26LL6oc+cSS920V4C2Z
	 oMn4cBTadvFG0PEP9gOhT7Th8kZw9jMm0F92lgkxrilODnw0ew5+HwRbD1rNKxNTIR
	 PJf1n5l9G12VLk0mo/kREIOCiU8MrlG2B/+VhY4MncmROTmvvAEsigw9eX4iYX8U9U
	 ZUCtUCO4FrrhgpwwpHeiMargjvOtRII5usBs3soQ+khakTaVrx3yC4l3xnG5OxsyL/
	 AwgqXRjF+jeiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C17CA5FD6;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 01 Oct 2026 18:55:35 +0200
Subject: [PATCH v4 2/3] pwm: meson: Add optional bus clock for S4 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-add-t7-sys-pwm-clk-v4-2-8ed2b1e0cdfe@aliel.fr>
References: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
In-Reply-To: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=glXVB2ABEZoXCQ9h/n4MfGeusOZpwiDdC/TOxoAXt/A=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a+CZvDb4u/m5OYfMPL9dz5S7emuekVdFtMjarYKRU1M
 f7kr6nmHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEDlsxMswS8jn6UvLrQYEd
 iXoRDw9yOPNmLDi7ervgi+x1vzlSrpkxMjyUf9y2q0JJfHaW8KYDuVO6/krtfrdpx5e5Vs/UTLY
 sCOEBAA==
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
"bus" name. The clock is optional, so existing SoCs and device trees
that do not provide it keep working unchanged.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/pwm/pwm-meson.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 20e6cd07127c4..3ed6098dc5f00 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -508,8 +508,13 @@ static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
 	struct device *dev = pwmchip_parent(chip);
 	struct device_node *np = dev->of_node;
 	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct clk *bus_clk;
 	int i, ret;
 
+	bus_clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(bus_clk))
+		return dev_err_probe(dev, PTR_ERR(bus_clk), "Failed to get bus clock\n");
+
 	for (i = 0; i < MESON_NUM_PWMS; i++) {
 		meson->channels[i].clk = of_clk_get(np, i);
 		if (IS_ERR(meson->channels[i].clk))

-- 
2.49.0


