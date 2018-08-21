From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 00/24] TCU patchset v7
Date: Tue, 21 Aug 2018 19:16:11 +0200
Message-ID: <20180821171635.22740-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Jonathan Corbet <corbet@lwn.net>
Cc: od@zcrc.me, Mathieu Malaterre <malat@debian.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

This is the v7 of my patchset that adds support for the Timer/Counter
Unit in Ingenic JZ47xx SoCs.

From v6, only patches [05/24] and [06/24] were modified to fix a section
mismatch. All the other patches are the same.

Thanks,
-Paul Cercueil
