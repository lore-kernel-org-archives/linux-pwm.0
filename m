Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563003D9691;
	Sun, 20 Sep 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905772; cv=none; b=dVx3H+JWbSvAS624FqVJ7b/8umGMC8a3eCwzMs3cJihD5Udfee7VecBNrI6y0rQYvW724neu8FldJ3NfBesZrnJ4A4fBuMuP4fOn5qjpBDb/y8Q/HwCotKqLw+MSZ1vLSmcuog9Ml+QJ39phVyM8FpV4wIl4k+OcvnYoYWlrSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905772; c=relaxed/simple;
	bh=jxDt2zEfr+Z875on6vZ1E8Zc9mlwzhUL++PYpDz4v1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7qZe/PCdGV/CEnqid70UBvwGw3OVSzTtPDDoLi28Sx2NpXqR6+cEKX9lMRrm59CvUdU5huWiCnyoMbFb0GjQQtYPTsywBS1cI3ZdZ29mUJoUAdaWmK8s3DdhdTuWzLoJadozX8drV5Xt9tsOV9SevB+db2G26z2geQix7OCEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd5T8QNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd5T8QNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 221A7C2BCFC;
	Sun, 20 Sep 2026 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789905772;
	bh=jxDt2zEfr+Z875on6vZ1E8Zc9mlwzhUL++PYpDz4v1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cd5T8QNZA6b0H4NimcwnGNtLaFKeO31mT5ufjQnNH5priiGnhTqfa1eN0Uqsk1Ri7
	 F3M4baP5EA+SjRU+vvc4mwL6fuQ0Tzfe3bjjy/IVzU5c+yS6NI0k3Wwg+dK9rxU/aX
	 bkM5cR0cvTKyu9SJOwVN5zofHiGnA01o68L12fiIwy/ybLEarWCzMVDv5NtgHR7e3g
	 Ntl3kF3XNlnJ48teIp7kr3psEAi4lODmFCuODl6IgPFJ/pbFtH5XaJOL+zOKLLYTrd
	 RZNBYYeP9CALSwi6LfEy84aKhL4sfZWcXgXQWv+fGxUhNgjOjgGC/RcHHkM+jvEhid
	 h/lyD9ADRf2OQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0553FC982DA;
	Sun, 20 Sep 2026 12:02:52 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Sun, 20 Sep 2026 20:02:08 +0800
Subject: [PATCH v4 3/3] pwm: loongson: Use field helpers for period
 validation
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-pwm-loongson-fix-v4-3-41b36b3c6497@gmail.com>
References: <20260920-pwm-loongson-fix-v4-0-41b36b3c6497@gmail.com>
In-Reply-To: <20260920-pwm-loongson-fix-v4-0-41b36b3c6497@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789905770; l=1574;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=y8tF/NQwV1xqRjbBFvvs1zZHcp9ww6rdG1gubXIGg+c=;
 b=MNU+K3C3DUDWEDrHPWSs95S3BRoARMbgu6OZqgwmWf09utvFBtGkD5IStGw3Sf60SWihY9VU/
 neEUbOoSwltApQclCphLn2VZeqhCD/W/mVyNVZwEr9CobdvVNOBeJwG
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

Use FIELD_FIT() to validate the calculated period value and FIELD_MAX()
to get the maximum value allowed by the 32-bit period field.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 977d867bdb8a..178a7a69a11c 100644
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
2.43.0


