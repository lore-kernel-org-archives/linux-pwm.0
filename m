From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] switch to atomic PWM
Date: Thu, 2 Mar 2017 17:28:43 +0200
Message-ID: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
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

Changes since v1:
- update only duty factor without disabling the PWM channel
- if PWM channel is enabled, period, as signal polarity, is
updated by disabling + enabling the PWM channel
- atmel_pwm_config_prepare() function has been removed and
added instead two functions, one to compute the CPRD+Prescaler
(atmel_pwm_calculate_cprd_and_pres()), one to compute CRDY
(atmel_pwm_calculate_cdty())
- atmel_pwm_config_set() body was directly moved to atmel_pwm_apply()
- add 3 new members to atmel_pwm_data: update_cdty, set_cprd_cdty and
regs:
	- update_cdty is called to configure duty factor without
	disabling PWM channel, when necessary
	- set_cprd_cdty is called to configure both period and
	duty factor parameters
	- regs keeps the period and duty registers and was added to
	have common functions for update_cdty and set_cprd_cdty
	members of atmel_pwm_data for all boards;
- add a new parameter to atmel_pwm_disable(); this will be used in
updating period + signal polarity by disabling + enabling the
PWM channel. In this case, there is no need to disable PWM clock
since new configuration will be imediately applied.
- adapted the other reviewer comments excepts the one regarding
"cdty = cprd - cycles;" from atmel_pwm_calculate_cdty() since
in atmel_pwm_apply(), selecting polarity in the other way arround
than is currently done in this commit will need the changing of DPOLI
bit from Channel Mode Register, in order to keep the initial
output level of PWM channel after disable operation; this works
for sama5d2 but not for sam9rl which hasn't document the DPOLI
bit in datasheet; sama5d3 also hasn't document the DPOLI bit in
datasheet; one option was to have different aproach for different
boards but the code becomes messy.

Claudiu Beznea (2):
  drivers: pwm: pwm-atmel: switch to atomic PWM
  drivers: pwm: pwm-atmel: enable PWM on sama5d2

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 274 +++++++++++----------
 2 files changed, 142 insertions(+), 133 deletions(-)

-- 
2.7.4
