Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF343DCD9C;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476686; cv=none; b=k/qjt8N0RPJcow5djHTRBN/78vksbIDwvWGftyI3Nl6wuVwR2trbD2mBBIm7w2Pgk4P/jKqTWA39sKGP2+jnq1D9zsNBMsKaOFvAUW6mZmY8uYeGxp5RmcrA9O6BbsK0Xn432egb9BHnm1s1CsjLa3AyDH56R1gj8WbxQ4N+b8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476686; c=relaxed/simple;
	bh=Fzow+C1xiM3hjgNnH33AjG4WVfsg07VQlCQULxGTsGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPcFCIFcR6DYrwA+p6mko/tgDG047gQygCD8Yzs97bwpZNMcB2Z+Zi9zQY792dGTQmONs6sM2hiVt/Ej7fQoiJpkM7CDVGXJkdVZCyKQsIxCGV4/DkFcTJRaHnkLXsTCz6ql9ziMkJjTiAyoQgbRCtQvwEnRWlpyoDa5EB/YYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpT5svnB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpT5svnB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B04F8C2BCC6;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782476685;
	bh=Fzow+C1xiM3hjgNnH33AjG4WVfsg07VQlCQULxGTsGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IpT5svnBjngt27jkquMsdadkeNEJFSyBs9pFz4clW6cSRGue1Cp1BC2h5g3pwil6x
	 OsgKPCf9A37wyr/cOnQf4Qeos8n2hggtX6iRFPikdExOXRS4G/RmpUnBynS22VFdnL
	 0KT6k4/G13UE3E44ZxJkXTq/oj5JUNThu49Lu3jwXLr9TirDSHvZ03VWcQE3Q6fx/S
	 3bRzWKoGLVEz6o1wJkCuNjnrc9EqrvXjATxAZDGJXxyR9AGYMUISnejec8I5XJ8RMO
	 PT1dNs4z/i9jvC4cCEeBt4ZbqVUW18a9fX3YJKjcK9QUu2DrH8NvmR3TqMj5GfSmQq
	 z+8+gnI3b2Kzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAC8CDE013;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 26 Jun 2026 20:24:23 +0800
Subject: [PATCH v2 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-pwm-loongson-fix-v2-2-5492db953879@gmail.com>
References: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
In-Reply-To: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782476683; l=1528;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=WKaBUbBwEp56BQVM1m/OWceSdP7Tfsab3W614QpROZU=;
 b=bBfJDX7LTO7CnuOmKaofjRo/2vPxnRjSTOJCgj0u7FfUIVKi+XzHibYA55IJ3+VD7zFhDhB1f
 3M139q5GWxRAJKUvNRN32EphIUxi0Lxfy+ghcKtVGWWT8YuFyBk4hW7
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

The Loongson PWM controller latches the LOW and PERIOD registers only at
the start of each PWM period. After disabling and re-enabling the PWM,
the controller resumes from the previous counter value and completes the
current period before re-latching the updated LOW and PERIOD values.

Reset the PWM counter when disabling the PWM and release it when
enabling the PWM so that the updated LOW and PERIOD values are latched
before the PWM starts running again.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 69514b5a1324..eec110ed9be4 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -103,6 +103,7 @@ static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+	val |= LOONGSON_PWM_CTRL_REG_RST;
 	val &= ~LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
 }
@@ -113,6 +114,7 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+	val &= ~LOONGSON_PWM_CTRL_REG_RST;
 	val |= LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
 

-- 
2.43.0


