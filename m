Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795116484;
	b=Gvz9/IyfMeO6An6yySe/azWwP13motxP1wW/pdmKLxs1QpkimumcPEw5nN0P5POGPjyr
	 fxKWsqsDWMZ/LnZLEopE0v/jKnCHxLRYiKMmWu7v1OTX2FSsLAMi8PxQdVfdVeRg67Azj
	 Db8W0PbtANlMsUFlm8xFtd4oFsT93A+JTNzzlXdEsfdHTxp9bfTAhPv/sG4PbdpOe99Rs
	 uiW6z7Er0EyYDQbSfHmSkt1cM2wGs8VbreYDYuNf8QOsEON+SKfV4/Ghf3nCdZBtf4tJo
	 mhO6bx1EwWQKb2MyPRMb0bsxT4T+31Vpp5jV8FjeeeQBWPIXw3gtepDBU1nRenqougA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116484;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=wpCapHYlbURUuBsST4Rt6CMoWh75ypRX0FOD72aaoso=;
	b=FPtuJXuUmZWmBDq4vv7Cdctgk/cQ7p9OYE8NqKFrhDDHJQPi5IzoO1fbckO43KS8U427
	 xr+Zyq0Ewn0BRoopnrBrrDha5mSUHEHBPsqpN1zNGGVKdcRt5mVeePjz9a6qTOnDN6Xh2
	 n0H2TArREXjZXg/W+F7NbpxTsoDUKhvQd3e7QoVWPA1hYhnQdt0ryjyHifDo8TEfP9VbS
	 pmAnfiCs08ek+w/ZOLvckb/e7q9go/xJmtBDsdWzyPnZz0as9bqXEBSGfj3Ogrusk0UeD
	 OMP2b1ExoVsVL1UIX9Ecg4UA5A/7sBM63LQWcNmGij0soxDcgG3vKiO6bMFZXdd+dog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5g3Wnq+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7D606A320;
	Thu, 19 Nov 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5g3Wnq+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795116484;
	b=K08ObJx4sIfLvno1CAx2usl1gzFwj35LK0radPwdhGFx1pVAnwW8fz6xNOQ0PHttTsG+
	 LLM4sCps/FSa+QVey7LIbjhTVWS3OHKPrTznzUwOI2K6tup9gvx1EhHZOh0kzokGn4azo
	 /QS6fz1K2E0YdlQohwqtdK7HWbGp8Izk49BAYvGSdOWsS0qoacI+d5gn34+DWJ89UGxGI
	 d6GnOOHh0/7EJw1LWqtJq4S/iBNosF/lb0EPKS+7tVMdO6rxNmgQCn766CPgdnaFBkPqX
	 RJmuAT4QV4lsimZk1/yvFcV+qpWS8JKmHkerVkYkHF88shsRch5JLGWRYPRAEUMhwgg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795116484;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=wpCapHYlbURUuBsST4Rt6CMoWh75ypRX0FOD72aaoso=;
	b=WLDsCdfAlPVQFUezECA5HGUF4ZPsnjdkl8eBcdpJTJTAcM84MVMCIz7zm1GZ0KwM+CRD
	 H9w4b1ldTgW5ZCaNRmiXOqbNtGjoWUcrezPOr0kYyhqw+7/0k0ouzrmp//pejSc0tCGx+
	 qIjj7sWwr/sMEtGmk8b8RMXH6KSasc1W1UIJsew5o2xMIZg6b4XtFuKm7Yic+bENdoIV3
	 4teocDKixDGaf4Jwqa3PcfNcuLQ+ii7uM78ExXf6zoY71ZOsyO/qvDW/64S4VozEdfhiK
	 n4HUyB/wQM2hM9HKDX5XLBRjNZoarn0kRQgjqda6Z7sJGNaoleKFIMIxY57ckRfPNpg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF6081F000C7;
	Thu, 19 Nov 2026 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116484;
	bh=wpCapHYlbURUuBsST4Rt6CMoWh75ypRX0FOD72aaoso=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=e5g3Wnq+bnURVJlGNNwQ5PxjbjjIXPwwxh7AS7JucbzT5SxA15zSIbdOO76azikba
	 SDNh3VcX878rRVsZCPghvWfZPZhrDaVP8u1CseRyjnC5R0sVSd6umvLaMQ9D4Of3wm
	 zKlb6wgtDUY7ZeN9Xza6XSCUxcjfSMyoOrVK4V7r0/nGKbqILHg1E0i1E0NPtiG18J
	 l92R/CpGzmlOz0F153XQcZFdgLFHYmFKP4VtvPvyH9FyhBrLi9HV7YXMeWy+lThPsa
	 /An6rfzRmw+EA+0xUEYhoHONtGTytm9T+rot09D8dvBGnMtcRYdEkU5kUgrNfoGT/p
	 wB3gvw5Zeim0g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2E8B84B3EF;
	Thu, 19 Nov 2026 19:28:03 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 19:28:02 +0000
Subject: [PATCH v2] pwm: Drop the module reference before the chip in
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
Message-Id: <20261119-pwm-v2-1-fe761df4f272@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMFN/2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0NL3YLyXF3jlGSLlCQDcyMzU0MloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0Aadf4RmcAAAA=
X-Change-ID: 20261119-pwm-3dc8db072651
To: ukleinek@kernel.org, m.wilczynski@samsung.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795116482; l=1837;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=jU7pi4yuE2f3TtWrb3aU0gY1rBGzqQsso5D2Sa20T0U=;
 b=b9OLKs/Bm6WhAwXYM7jiPZyYPyKDjRH2gs7/gaItPByrCW8qwcHFbFkVrP+1DmEBTZOsL1UBZ
 yMvlSpjEv5cCTAJNKpgEsDoCOXQPr3pGLSzy9/aO6w0r13cYeOhjyip
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

Call module_put() before put_device(). This is safe because the chip is
released by pwmchip_release() in the PWM core, not by code in the
provider module.

Found with a static analysis tool and checked by hand.

Fixes: 4c56b1434b81 ("pwm: Add a struct device to struct pwm_chip")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Changes in v2:
- Call module_put() before put_device() instead of reading chip->owner
  into a local first (Uwe).

Compile tested on x86_64 (W=1 and sparse, no new warnings). I don't have
the hardware.

v1: https://lore.kernel.org/linux-pwm/20261119-pwm-v1-1-adeff0cc366a@gmail.com/
---
 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4c6d716e5fde..4e8dba089261 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2036,9 +2036,9 @@ static void __pwm_put(struct pwm_device *pwm)
 
 	pwm->label = NULL;
 
-	put_device(&chip->dev);
-
 	module_put(chip->owner);
+
+	put_device(&chip->dev);
 }
 
 /**




