Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795085779;
	b=5E9SFHvn/bYKCaAHgIQLENojoMt3BwRIq+L83P5osQRuzQLpJC288QaOivdqsTfJ3Pjm
	 psdHrUtBEyQH9eDGTtEhqvxwYaii3AC53/qMW/XIJVIwePip65uehRGU5psoUDw4emG1r
	 hq872fm6N+yiSlZ3HQeG6v+kEY+g3d/Pc+IbUEnjDLm3+uO64rcGXungClqXWjv2jVn4e
	 uJJzcZkViIjfBDl5Le/+3r0x9x77xpLrFPJzUpWMdELMzswfXQLdA8hlYaJVkkE5GWLF2
	 9dvQad1hIYTS8af78DtFHItwLGCFNJb4tINbj0oYZhPgbbzVcSa5CbX29DcJJA88SAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085779;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=TT5Zv18zzhPxTIO9MQPj2JkdchjggYrubOF+S8W9hw4=;
	b=c7fyhG7QJD8j7zsrIWvQVzHyuifZUqL9+rD5aXLzNemwkN8dYxU9BfRVyv4nw68LYiiL
	 GcaFeWtqoS4OCCH2GuYKvBiJQTclhj0ysruEoc1as5Sva8gYyhqjVjRc1/E/1YdHN0M38
	 fW0yB+0AbqXdUsaO+XW3FAhWDbos85R83iso0JUT8vE3mvEtitXiby5aa1xzWOmZdvI7M
	 b54Imc2pvNZqVVa3uovUqUd+zc9sOwPNUzeFGwWY+joSlmQQcLo3SaHJmqCrXowvcUj55
	 YbDpKA0es7M9Tjd4TGLEmWGK+oTwbqm4CdS2Ye0Z/23b/xZrX0+SuAZvxpKlw1Ht6RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lm80VAl9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398A606A320;
	Thu, 19 Nov 2026 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lm80VAl9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795085779;
	b=yrGKqIxFjkqggT3ZlAgWOaGMtLZ+quInI+BOdPCuAXpP9C4/Qb6PRFHfV+u2CT5XLgSw
	 gGVPFEjmzX7SsZKxQiNzz4gxoWp0bfsvHlpGBvemM5OErQ8j+RlB3B0jporUILdfSA5yv
	 a4KGDiJWpdG3GBQ6xB5w9cotqohROlxZdnJGCYrKT1gOIZY18cjA9SkmdG0bMQ5sc3aEW
	 gcULElUezf8s2QXmr2d4aBnaV9x/i64ZSKwOeDrSfs6aaEfwhntLXThBvzwzOK43z6ylE
	 gw5YWdRaKstDJbCQXvJmaiThId8r28/kvW3qDA+yAG5S43s1AAhfxL4a0xv8hJ/jwDQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795085779;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=TT5Zv18zzhPxTIO9MQPj2JkdchjggYrubOF+S8W9hw4=;
	b=ZBpb9ZelptSXaLB1aXUrUmElIIDMm7n9HUI5Em2KmSo4uv1zlVBhdk1t/2+u+f5PlwFw
	 ax8/17FkQh4I4srcldv/EgdTzSkyV1SK64WI3c8RXl+9BjRujJJkIuIhrgxHri5oqQbqw
	 yu5PZm2/AqXBG0I+xd6bhq//IwXe1nMdP+6wg+F/4FrLpVezFk18TlgG3sqPknmv8g+sl
	 rbZxJL+bk5MEHKtJPvUeBaqU8ShE1Bd13GVWbNUA8anX7rfxd/ffEagm5U86wf008Lq3S
	 Dlhj/iro+hdk9jg495/Wl12jsBf0rB5HzOCZ5sxyI8fl0i9E35s3TqN60+o9f8O7I0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C08331F000C9;
	Thu, 19 Nov 2026 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795085779;
	bh=TT5Zv18zzhPxTIO9MQPj2JkdchjggYrubOF+S8W9hw4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Lm80VAl9gKGW4CcbnU4p26xyeSkSpVnGyaCFbRSItpOqzuQNlFf0gMl57G4v+4PZW
	 hLWC/lY1C0OkcLULVdufGUp2aIOyY7XhvSHlXuVFrI+5P/m7XOXq92VrqtN6UudURd
	 jqgfkZ+ccKoZnSHOg00B5wnBJXW1W6AM4J2AG0OQSBpchlHPLPaEkM4MMcvzc2iqaj
	 gMLNXnoYtWfyTy13d/W2IL7w/W3oonPq3/Q3WfWcAwqC8+7PV1/q+OAef0C8Fb6oUY
	 frGDtBMfrqzplCee34rpDpGbif2BlWovvIb+8RS1MprBJX6vMBEjp2ZY4C3p20OVZt
	 SBnUvfLstazsA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 213AC4B244;
	Thu, 19 Nov 2026 10:56:18 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 10:56:17 +0000
Subject: [PATCH] pwm: Don't dereference the chip after put_device() in
 __pwm_put()
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
Message-Id: <20261119-pwm-v1-1-adeff0cc366a@gmail.com>
X-B4-Tracking: v=1; b=H4sIANDV/moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0NL3YLyXN2k1DSLJCMDS0Pj1CQloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AMCcNyWcAAAA=
X-Change-ID: 20261119-pwm-bef8b20913eb
To: ukleinek@kernel.org, m.wilczynski@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795085777; l=1758;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=aTL9kEFJ/2KUWaQPI32vzjKcn/Y5nqsqx2zxlXKIavY=;
 b=OdjzFDiKHlRc+nctzng5NG3aU5iRyCpyMb/R77YV+LChxy9Piz3sCrn3a1WCS6uS4Z/rR1F2H
 lMPWEpVoIHeBXZhGgWucsvqa14Poj4Zef660V/6MJNnnJqEoOYa6nsI
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

__pwm_put() drops the chip reference the consumer took and then reads the
chip to drop the module reference:

	put_device(&chip->dev);
	module_put(chip->owner);

A consumer takes both references in pwm_device_request()
(try_module_get(chip->owner) and get_device(&chip->dev)). The chip's base
reference is released by pwmchip_put(), not by pwmchip_remove(), so a
consumer can still hold a pwm after the provider has removed and put the
chip. When that consumer finally calls pwm_put(), the put_device() here
drops the last reference, pwmchip_release() frees the chip, and
module_put(chip->owner) then reads the freed chip.

Read chip->owner into a local before put_device() and use that.

Found with a static analysis tool and checked by hand.

Fixes: 4c56b1434b81 ("pwm: Add a struct device to struct pwm_chip")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on x86_64 (W=1 and sparse, no new warnings). I don't have
the hardware.
---
 drivers/pwm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4c6d716e5fde..8988a7dbe5b1 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2020,6 +2020,7 @@ EXPORT_SYMBOL_GPL(pwm_get);
 static void __pwm_put(struct pwm_device *pwm)
 {
 	struct pwm_chip *chip = pwm->chip;
+	struct module *owner = chip->owner;
 
 	/*
 	 * Trigger a warning if a consumer called pwm_put() twice.
@@ -2038,7 +2039,7 @@ static void __pwm_put(struct pwm_device *pwm)
 
 	put_device(&chip->dev);
 
-	module_put(chip->owner);
+	module_put(owner);
 }
 
 /**




