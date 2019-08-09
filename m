From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/7] pwm: jz4740: Driver update
Date: Fri,  9 Aug 2019 14:30:24 +0200
Message-ID: <20190809123031.24219-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

Patches 1-5 come from a bigger patchset that was cut in smaller
pieces for easier integration to mainline.
(The patchset was https://lkml.org/lkml/2019/3/27/1837)

These patches are the exact same as the ones found in the patchset
shown above, with the exception of patch [1/7] which now uses
device_node_to_regmap(). This function was added in a prior patch,
now merged in the MIPS tree.

For that reason this patchset is based on the ingenic-tcu-v5.4 branch of
the MIPS tree
(git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git).

Thanks,
-Paul
