From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] drivers: pwm: add pwm support for sama5d2
Date: Thu, 23 Feb 2017 10:38:38 +0200
Message-ID: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Extend atmel-pwm driver in order to support sama5d2 pwm
specifics. Since the new SoC supports changing of pwm
parameters (period and duty factor) without need to first
disable/enable the pwm channel this series adapt the
existing code in order to let changing of these parameters
for sama5d2.

Claudiu Beznea (2):
  drivers: pwm: pwm-atmel: add support for pwm on sama5d2
  drivers: pwm: pwm-atmel: add support to allow run time changing of
    pwm parameters

 .../devicetree/bindings/pwm/atmel-pwm.txt          |  1 +
 drivers/pwm/pwm-atmel.c                            | 40 ++++++++++++++++++----
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.7.4
