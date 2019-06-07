From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/6] PWM JZ4740 fixes and cleanups
Date: Fri,  7 Jun 2019 17:44:04 +0200
Message-ID: <20190607154410.10633-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

I rebased my patchset on top of v5.2-rc3 since it didn't apply anymore.
Patches 1-4 are unmodified. The old patch 5 added a SPDX license
notifier, but somebody else added it in -rc3 apparently, so I dropped
it. In the meantime I added two more cleanups.

Cheers
-Paul
