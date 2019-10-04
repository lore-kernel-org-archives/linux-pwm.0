From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/6] pwm: mxs: add support for setting polarity via DT
Date: Fri,  4 Oct 2019 15:32:01 +0200
Message-ID: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-pwm@vger.kernel.org

This series adds support for setting the polarity via DT to the
pwm-mxs driver.

The DT binding is updated, but I'm not touching the existing .dts or
.dtsi files - it seems that the same was done for bcm2835 in commits
46421d9d8e802e570dfa4d793a4938d2642ec7a7 and
8a88b2a2017d1e7e80db53080baff591fd454722, while
arch/arm/boot/dts/bcm283x.dtsi still has #pwm-cells = <2>.

v2:
- Rebase to v5.4-rc1
- Address comments from Uwe.
- Add Rob's ack to patch 4.
- New patches 5 and 6. The last one is independent of the others, but
  I stumbled on this when rebasing and found the signature had
  changed.

Rasmus Villemoes (6):
  pwm: mxs: implement ->apply
  pwm: mxs: remove legacy methods
  pwm: mxs: add support for inverse polarity
  dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
  pwm: mxs: avoid a division in mxs_pwm_apply()
  pwm: update comment on struct pwm_ops::apply

 .../devicetree/bindings/pwm/mxs-pwm.txt       |   4 +-
 drivers/pwm/pwm-mxs.c                         | 101 +++++++++---------
 include/linux/pwm.h                           |   5 +-
 3 files changed, 53 insertions(+), 57 deletions(-)

-- 
2.20.1
