Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795786364;
	b=E8lbUYlayJAPT2jFKXhxTL72vzi1OTDnK1wbVzFB8+06TGur+ETDcQDEcHGyH8uIM/H4
	 2YglOBPE+Z2eztA9o3eKVe3Cz8m+AqOUUJJcsIov0tvbdz4+CfaMm7pQ4hNMFkAl8hOMr
	 RkUOPGoYb1DPxPGM3QZeq1JLhP18pfzqWcIzT+7t2zafit0hetDHh+DKz3qCe1PLHwwIX
	 WTsmKv0iGDiv3k1f+aFGp91uU3SfjRHGmO1DNUo7Y+o7oA838ThIb4g7cM9dLwhCgRvfv
	 mOGL5PlZygfakHgrE0o39VQ5RWa8jCbVqByZGFSqpeZ3EKtKgK6HZ8GVvTaVvHr7s6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786364;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nJV6/fOOgnjHQ1NwB6EWRzn4p9LxctW86QJThrCN/W8=;
	b=S3xJIP9xf62itnFWsy0ecY6/riH7GusbfbxpMNjZW/3NA2AiVBA/h4D2Elx9Q23QgQqy
	 eXuLEv2yd23Wgd5dzOxHkjNxX+hPM8l4oxmm76o7Ekj36xFeAkFEJdqvmlf4g3HzvpfXQ
	 b30HraytLFwbCsV+TSww3w5uQ/RVwcHl4GlzblLPHyxKXTCRHH3qfdCtpqDnK+b/vSgId
	 J4wzmq+Wz40lD5yjCfq1+xYYRYGKHvYmzwfJ0OQiXEkxN7k1j/sEdifEFkiEFPl7Co3SN
	 iaAXPPJ1wVRCbZs9Z7hRi2bTOZWXsfeere8Ri66nxR+zqQK3F1U2UEAFtKzCvdSTVOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSPbUgrs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18A606A32A;
	Fri, 27 Nov 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSPbUgrs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795786363;
	b=f+trlzr+UaU5WA6+qDt/YIah9ECIP9r325Lp7gjBW4YA+bYqUFqZ5M9HJDU7r3Hubnbd
	 q6ZRLPD50ZPzII9AM0qbbWp1f2WLNae8Xny/4D1nKCyzefqQRcrvqAIi07sYPL9YyiiDp
	 LbGG+77MLP5NhUy5ciAioA7qlyGkPpMtOuoraIw+rqn8vIPQNc1IogLbyVwm8/+b5V9gb
	 JKwbwK38Sr/lUS3Ps/No5KDIYroTANOtjCun0By2059cnRga0dDgY8991DGY6412k894+
	 F7eerQRwGvpdeOd/e1PFOyhwth+frLn4HP1G3o7KEpje9TwPQe2UB8UaoYmNqTyERew==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786363;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nJV6/fOOgnjHQ1NwB6EWRzn4p9LxctW86QJThrCN/W8=;
	b=y0jCsvhaV9mrFLvfJY2/VLH+QiPtc7FzntnSqtRUeM3XBY4ihEql+cqTsJTYXsZlfBE6
	 tck2OX0ddfGkUFalyLAik3f86SIJate2oS+9ZC+fRvXvX9B/BVZwbD5+j4mXt8h12ebQD
	 piCdJeAlIJWLDKLVi8qPWpfELjE2fD4KrnYXZeriSPLImq7zT6wtjB8e98n94WB7wBHCw
	 QILLYRcAwLn+n7BFDb/cxmcfVJfFiykrfqj8DmKcHl8QM7/HjfIpvvZPwP998oFkWgS+j
	 Jr0RrJ9K/208cIG8t6MRg36zO1bFmIMjotdB7wG8pCsqAAwE1yvx6/tTD9xwn2QhgzA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E2A6E1F00923;
	Fri, 27 Nov 2026 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795786363;
	bh=nJV6/fOOgnjHQ1NwB6EWRzn4p9LxctW86QJThrCN/W8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CSPbUgrsUPMu91caEizG/DMUkb25J1WJPhwa98W4fIkT0vit0x107eU37RW2X9D9C
	 I5YNxKQ0tAXUfJIP1cgvsYIk/lZ0dWrQ3/a6L5F/yNKD3nhEC751V+yFTtKJ/lC5rM
	 71beMpRnFhojlrUFL/7nfYppnNPkIe9HCd0AUxc43KSP8yvL2J19MS7EBp6jojnIZE
	 2tU+fqpA9PSIIzb5GqAR6sYHhu1UbwNf/PTkH/0ywKsvMEOsUuDPnRv8ZfY9H2tUWK
	 awctz86ZuCXoILGFx4+o/7/XyDIy5nSswNxt9qs/B0E4fgDxXs0mP44ogp4OO/8BsO
	 XEIw8AQrat7AQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6DC1D4B810;
	Fri, 27 Nov 2026 13:32:32 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 21:32:25 +0800
Subject: [PATCH RESEND v4 3/3] pwm: loongson: Use field helpers for period
 validation
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
Message-Id: <20261127-pwm-loongson-fix-v4-3-607f325b74d4@gmail.com>
References: <20261127-pwm-loongson-fix-v4-0-607f325b74d4@gmail.com>
In-Reply-To: <20261127-pwm-loongson-fix-v4-0-607f325b74d4@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Imported from f20260920-pwm-loongson-fix-v4-0-41b36b3c6497"@gmail.com, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795786349; l=1574;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=dw6b52g9dClE8N8lKTN5RhDZ6+WGuUSpcSRiL+WUkiM=;
 b=HjhaJuQ2+PE91tNSjPT0IAc9Lb7ik2E4CZ4uOg3zWjd6Djh2DPbTdfoFpMh92oXetLYhe0quc
 dvWhxRcrWqRA2szbzXX7Q9DZJYuz0qQ5ia3g4/ipH/TCriDim+e6FLd
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com
Content-Transfer-Encoding: 7bit

From: Keguang Zhang <keguang.zhang@gmail.com>

Use FIELD_FIT() to validate the calculated period value and FIELD_MAX()
to get the maximum value allowed by the 32-bit period field.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 6f609fd0b90b..33367c7473a3 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -37,6 +38,8 @@
 #define LOONGSON_PWM_REG_PERIOD		0x8 /* Pulse Period Buffer Register */
 #define LOONGSON_PWM_REG_CTRL		0xc /* Control Register */
 
+#define LOONGSON_PWM_PERIOD_MASK	GENMASK(31, 0)
+
 /* Control register bits */
 #define LOONGSON_PWM_CTRL_REG_EN	BIT(0)  /* Counter Enable Bit */
 #define LOONGSON_PWM_CTRL_REG_OE	BIT(3)  /* Pulse Output Enable Control Bit, Valid Low */
@@ -133,8 +136,8 @@ static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* period = period_ns * ddata->clk_rate / NSEC_PER_SEC */
 	period = mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);
-	if (period > U32_MAX)
-		period = U32_MAX;
+	if (!FIELD_FIT(LOONGSON_PWM_PERIOD_MASK, period))
+		period = FIELD_MAX(LOONGSON_PWM_PERIOD_MASK);
 
 	/* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */
 	duty = mul_u64_u64_div_u64_roundup(duty_ns, ddata->clk_rate, NSEC_PER_SEC);

-- 
2.53.0


