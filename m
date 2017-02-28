From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] switch to atomic PWM
Date: Tue, 28 Feb 2017 12:40:13 +0200
Message-ID: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pwm@vger.kernel.org

Switch atmel-pwm driver to atomic PWM and
enable it for sama5d2

Claudiu Beznea (2):
  drivers: pwm: pwm-atmel: switch to atomic PWM
  drivers: pwm: pwm-atmel: enable pwm on sama5d2

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 220 +++++++++++----------
 2 files changed, 122 insertions(+), 99 deletions(-)

-- 
2.7.4
