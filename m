Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 15/15] ARM: SAMSUNG: Remove plat/regs-timer.h header
Date: Wed,  5 Jun 2013 23:18:20 +0200
Message-Id: <1370467100-10820-16-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>

Since all uses of the header has been removed by previous patches it can
be removed safely.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/include/plat/regs-timer.h | 124 ------------------------
 1 file changed, 124 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-timer.h

diff --git a/arch/arm/plat-samsung/include/plat/regs-timer.h b/arch/arm/plat-samsung/include/plat/regs-timer.h
deleted file mode 100644
index d097d92..0000000
-- 
1.8.2.1
