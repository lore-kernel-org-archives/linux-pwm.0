Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180B436379;
	Tue, 16 Jun 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608409; cv=none; b=BpCNZAfTnM2vCetOchJ8Utg1GKbX9eOcoN4Se5WYjjAMZeOjWNNu4/NDsssgG8tHeglFX5WjiC2AkZ76aKGgoFp0va4JChQszo/gWtbGFZVKo2WcMpJ1hlBVxwzlxg7GC+tpzWi/hg1l1kU4H0mUDOAzXo3f1HzWfwpqBs1wmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608409; c=relaxed/simple;
	bh=NQcRfloY37BJ63E2hMgEtrbL6Ikpgzo6TOQ+KRqAqXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVifVqoRmSExT5hFg8rYTLeBrfdQqYwZc5Ok340Ks27l+6DJKdyd+Z6D03adw8A8aarHod3T3SNQ/S5dfjxu4vbTzJfg/3XrcpsHXJiQTjfKUsjWTycnhjithNIsKHX7L1yEmGmVyRUwKu+jOKDn3rR1QKCDvBwrFQlV4eCd90E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTEQRPHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTEQRPHv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13A39C2BCB8;
	Tue, 16 Jun 2026 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781608409;
	bh=NQcRfloY37BJ63E2hMgEtrbL6Ikpgzo6TOQ+KRqAqXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DTEQRPHvR5WRIBHZ2q/+/jwM7v2Cp095d8O6mUthUJqmUR1uAV9gz/oPSSitJHE0U
	 1AtbIJ0znWz+hvqAfn34CmTwVUwa9B1ki7D3jCc5ElcLjALDnv5TuMFPq/Amv3+I0v
	 Qt2xQUWes07T/ZuJfhg6jqAa1SwDVCyjBzRh+01Xu8pPpWO+D8dAUIeGvjKbwfPW8M
	 MqRSwU7S/9fjNXye/wZSKEL/dpd5jpYsuk4xj09BKqQmDsRmsXTqPDDStliRk/hoLi
	 M4YnU1wTkAxakhcTgH4Jb+unwXGn1JvMYLdpZ1HNQ0a4YtM+nWrvL7PN6Kdy6Tuznj
	 fCfJeTBc6Ngig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EAECD98E6;
	Tue, 16 Jun 2026 11:13:28 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Tue, 16 Jun 2026 19:13:18 +0800
Subject: [PATCH 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-pwm-loongson-fix-v1-2-491dbf260a7f@gmail.com>
References: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
In-Reply-To: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781608406; l=1462;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=gA7rBvBB2Sub27SnbTAe9bo34GLjvfL8/AMyT7b0/So=;
 b=CxJv9TjcbMOT5ECEV6qjJLXf0uHvkWiUq+iREd26eQiuA6gTrL5gNGkGVXLdCv6Clchv5tNqf
 aL6EFdsx5OeC4MEpMLTaVqr7AC+DZGeo6c+Y3N103VdVVn1Uj0rkTWC
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

By default, the Loongson PWM controller latches the LOW and PERIOD
registers only at the start of each PWM period, causing configuration
updates to be delayed until the next period.

Reset the PWM counter when disabling the PWM and release it when enabling
the PWM to force the controller to re-latch the updated LOW and PERIOD
values, allowing configuration changes to take effect immediately.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index dc77f82fd888..eb89ced530e1 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -102,6 +102,7 @@ static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+	val |= LOONGSON_PWM_CTRL_REG_RST;
 	val &= ~LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
 }
@@ -112,6 +113,7 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+	val &= ~LOONGSON_PWM_CTRL_REG_RST;
 	val |= LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
 

-- 
2.43.0


