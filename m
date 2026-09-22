Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A347D927;
	Tue, 22 Sep 2026 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077127; cv=none; b=G5rYMExBDT7eWCU+1U07mNI5hfeKVrHsqFfEV7Ar4ehcMlJUeAE8dUYASbaj4rQMX+JydWJlM2kqi6MCGHvWhC7lVXJRXN0ETl3dVdNG81rfbO8Plv81/G7HicXhUyPytXdDl/lyVAazssuG1ZUPleBZFXauidYP43G7Q2ulR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077127; c=relaxed/simple;
	bh=CNcIF/bBl59gDLz6K9vpIOEvLhgEfb2lK1cP/xPcNok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gedwT/AcR/euW7k4bmA5Lqwjmip0yewVhp9XD9cUKKW9sYL+Dk1YnZYflwuRhUF2oi97eKhnEz1r0iltZaLMEacyft82SkSeXeGP0eMOyNA4NiYz4EyJVqONuQkPWMFaM6RjR+EadGAg8oDgqgG6i/8BKXElrG21RmQ3i6vjHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5RONLVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5RONLVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54251F000FF;
	Tue, 22 Sep 2026 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077125;
	bh=Ob7jihC3QWzpJZqECes5/mW4OZ1MSKF4J2KhX+VVTEA=;
	h=From:Subject:Date:To:Cc;
	b=D5RONLVSip7Zv1V8etdQPWOLoeJZFQaFBKMaB1UxRHiXTKWQYcD8NzKRJ/YEyzMK5
	 WgFPyoWsJHlYjvcBjGF7s4Kg++Jl6ziTPktZ42Pa+uxs8/oCVxsuHO6xpnkTBEFnMs
	 CxTnwjRuDlBKr8TsFCJiH2NZLQuLFDFpmiS86M67STkojZEXCBm2zWhSxXGKKw6VYZ
	 NgprNqdnDI+oiP/OS1jBouajYbNn3FW4eQAjjwJ7q/mX1oG/Gm5O816ono/FwBOdK6
	 rOr4wpxUUjEBikWzJPWDygcTX8K9X05HRo7v9c/KmliAWPfGUhQdKWN831mYbNMFSG
	 Zd5lBMp+OrK0w==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH 0/2] driver: core: Allow drivers to opt out of
 driver_override
Date: Tue, 22 Sep 2026 13:38:27 +0200
Message-Id: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB2Ig1riVYoLTcZ2ujAyiUEQ7
 960bh58i/efEFmFIwzVCcpZooS1oKkrcO9pfTGKLwYy1BtLhF4ls2Ioo+IZw5Yw7AnbhyFrls5
 3zkJ5b8qLHP/yc7wd9/nDLv1ycF1fIYS5j3sAAAA=
X-Change-ID: 20260922-driver-override-opt-out-470290f5d5c9
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=treding@nvidia.com;
 h=from:subject:message-id; bh=CNcIF/bBl59gDLz6K9vpIOEvLhgEfb2lK1cP/xPcNok=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqsmi+T4am/1wuEkp8JdH7tMcAMkTylREKIqnwI
 NU1XVPGPNKJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCarJovgAKCRDdI6zXfz6z
 oVfsEACgiHotyvFNvjXO3PiMzZCjDUyTjbWDwtIbbjN6WBZ1LqkjyZxkVIw8qwZN2kiUha/VNcx
 ZNLHfzoKcUcvDQKfbsT66cIUZY7yxZ3J8Yqt+0a18UbZOoV7Od/l8QrUThwlmErKFhwjsTioTmn
 z1UAedgf6o/BGort0d/OfY0a7R3O13p6Pa3QhA7b9UJErjf14A2i10E9STtBV53cfXxGc0gNLtd
 BoNcS5k+NNfYo+X6wFpAG/EYMFuSVGb8y2Q0qJ+kJTbFu0MaG3Xmb11WwMZsxECVDCYWGDAqS5B
 KzqagT6gtVNZPl4F7T3ozX6M4lhLeej46a0YutIQxStJpFY7TIIB/JFM351ZXBhXAGqcSuTBOuu
 +sFy0rjBGVcmQxZidivH0H6vjs2R7XYe90gzXFhfY5MZxUkVbl+UWz+dswLuqXPLbYs7omLrvyc
 R7bCcnExAmoLidP1/i2BE8M6BEJpYYdo8xBgPgJlIgkhnd8TwBPxGCUp2qmc4BEoBaoJEqoWHNm
 gR6yx+6OXctf7EO/ylj+zEODVtDGZZa3dfSl1+M7vQ3F9HYwE2twHi6xbIFPQeW6nyPWPGhh1si
 ikl4PasNd8l0iwRztzBQKD1rY1NbcSisT9sMOBdnzOM9ocD1LQFZ8s7Q7t7eU/+IuxX3XYU9kNr
 LagMN7LD8mJrTwA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

Overriding the driver to bind to may not make sense for some drivers.
One example of this is platform drivers that use device data obtained
through device ID matching (such as OF or ACPI) and they cannot work
without that device data.

Usually the device ID matching is the only way that such drivers can
match against a device, so drivers shouldn't need to check that their
device data is valid. For such drivers, driver_override is the only
corner case that can lead to a case where no device data is found.
Instead of requiring each and every driver to handle this case, move
handling into the core and let drivers opt out of this override
mechanism if it doesn't make any sense for them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Thierry Reding (2):
      driver: core: Allow drivers to opt out of driver_override
      pwm: tegra: Opt out of driver_override

 drivers/pwm/pwm-tegra.c       |  1 +
 include/linux/device.h        | 12 +++++++++---
 include/linux/device/driver.h | 12 ++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260922-driver-override-opt-out-470290f5d5c9

Best regards,
--  
Thierry Reding <treding@nvidia.com>

