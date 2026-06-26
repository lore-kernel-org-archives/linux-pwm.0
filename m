Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05A3F484E;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476686; cv=none; b=r+k+HbrtxzFwnedIyeCZzLnQ9i/x6LELWMwzF/9p+Phy8o7EUS7v5fUoSW9mjGXX+MbKVaq3NTcdt3vh4OVgSnKYw4XqvK7bLIRhmeJW2oxK28HMx3a21l5j17Fu+65y6hZ//5wkLFM1ytijPw3B9Y3bum08cZK5UntOEw7q7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476686; c=relaxed/simple;
	bh=oo2KlzchszEKmeSlzGlrVuSsrAVnItDyZhmcgHfi0oY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hABb0bHIu0fXGPWPSWV3Hciknaefsyb7eI3QB541fpm//314jRfhKfmWjbxdUFW+D9HN+HekSaHK3+R4SSGkTlIpEascqxVBeWwqircpGRuHgdbG93zttxs9dyElHdS2Ksn3+4qv0OM+l5XQsbS2D/7DBYdLnFllMA5YIgF7VJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+yGa1XE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+yGa1XE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9875AC2BCB7;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782476685;
	bh=oo2KlzchszEKmeSlzGlrVuSsrAVnItDyZhmcgHfi0oY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=R+yGa1XEeK/qR4yxy8zPolNmFoe5HO/EawNO9Yc6uRlG8g28FGQR2n0IPXUu8bGBh
	 Bf8mOQG9BDqhqpXeNJYAhdk6fJSYp8PQl3jMJA5F4rmz98soy71/ZrLjDP+M1t8h3N
	 Y+wypl5fkX0P4yLoBhid2T8We6HTrPFsoHoDejPQuLQwrxjA8Is6DXPbpx4MUz+8Ae
	 A083wf1CyFLnyqcsEH/QAoTH3SQ1dC9orvV3of0XizMWeQuwE6YFdZguJQO+E1k5Zr
	 dbFrxHJ4CQcq5kpR8Kamc6BRvRZh2ruytB8YYq20kkDwIzadrvUJe5W7W2YbNoSKCz
	 IcllxUO2dmabQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C354CDE00E;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] pwm: loongson: Fix PWM configuration handling
Date: Fri, 26 Jun 2026 20:24:21 +0800
Message-Id: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVvPmoC/2WNQQ7CIBREr9L8td8UqNS68h6mC2yh/UmBBgxqG
 u4uNnHl8k1m3mwQdSAd4VJtEHSiSN4V4IcKhlm5SSONhYHXXNaScVyfFhfv3RS9Q0MvZGfRStG
 cmO4ElNkadIl35a0vPFN8+PDeHxL7pj+Z/JclhjU2HRvvplRUa66TVbQcB2+hzzl/AP62C6SwA
 AAA
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782476683; l=1224;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=oo2KlzchszEKmeSlzGlrVuSsrAVnItDyZhmcgHfi0oY=;
 b=qNJb8qLIPXV6XX5uBmcZnye20QRHXS9ZDd35ewgEa3iqZ7zJfw7kKAODKUF6uiwsRbBweZ2aI
 GmqMfdm1jzBBDoWSj1RFEv2orvOlUGBI6o4sggv8QwxSgv5wG5krdJM
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

This series fixes two issues in the Loongson PWM driver:

- Fix the handling of the Low Pulse Buffer Register, which was
  incorrectly treated as a duty-cycle register.

- Reset the PWM counter when disabling the PWM and release it when
  enabling the PWM so that updated LOW and PERIOD values are latched
  before the PWM starts running again.

The fixes were verified on LS1B, LS1C, and LS2K0300 boards.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v2:
- Drop the -ERANGE return change and restore the original behavior.
- Use mul_u64_u64_div_u64_roundup() to calculate the low pulse width.
- Update the commit message accordingly.
- Link to v1: https://lore.kernel.org/r/20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com

---
Keguang Zhang (2):
      pwm: loongson: Fix low pulse buffer register handling
      pwm: loongson: Reload PWM configuration through counter reset

 drivers/pwm/pwm-loongson.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)
---
base-commit: 8d6dbbbe3ba62de0a63e962ee004afb848c8e3ac
change-id: 20260612-pwm-loongson-fix-183763451e93

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>


