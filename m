From: Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v13 0/2] PWM support for HiFive Unleashed
Date: Tue, 11 Jun 2019 11:14:42 +0530
Message-ID: <1560231884-15694-1-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Cc: mark.rutland@arm.com, aou@eecs.berkeley.edu, palmer@sifive.com, sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

This patchset is based on Linux v5.2-rc1 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be
found at dev/yashs/pwm_v13 branch of:
https://github.com/yashshah7/riscv-linux.git

v13
- Rebased onto Mainline v5.2-rc1
- Correct the order of pwmchip_remove() after clk_disable() in .remove()

v12
- Rebased onto Mainline v5.1

v11
- Change naming convention for pwm_device and pwm_sifive_ddata pointers
- Assign of_pwm_xlate_with_flag() to of_xlate func ptr since this driver
  use three pwm-cells (Issue reported by Andreas Schwab <schwab@suse.de>
- Other minor fixes

v10
- Use DIV_ROUND_CLOSEST_ULL instead of div_u64_round
- Change 'num' defination to u64 bit (in pwm_sifive_apply).
- Remove the usage of pwm_get_state()

v9
- Use appropriate bitfield macros
- Add approx_period in pwm_sifive_ddata struct and related changes
- Correct the eqn for calculation of frac (in pwm_sifive_apply)
- Other minor fixes

v8
- Typo corrections
- Remove active_user and related code
- Do not clear PWM_SIFIVE_PWMCFG_EN_ALWAYS
- Other minor fixes

v7
- Modify description of compatible property in DT documentation
- Use mutex locks at appropriate places
- Fix all bad line breaks
- Allow enabling/disabling PWM only when the user is the only active user
- Remove Deglitch logic
- Other minor fixes

v6
- Remove the global property 'sifive,period-ns'
- Implement free and request callbacks to maintain user counts.
- Add user_count member to struct pwm_sifive_ddata
- Allow period change only if user_count is one
- Add pwm_sifive_enable function to enable/disable PWM
- Change calculation logic of frac (in pwm_sifive_apply)
- Remove state correction
- Remove pwm_sifive_xlate function
- Clock to be enabled only when PWM is enabled
- Other minor fixes

v5
- Correct the order of compatible string properties
- PWM state correction to be done always
- Other minor fixes based upon feedback on v4

v4
- Rename macros with appropriate names
- Remove unused macros
- Rename struct sifive_pwm_device to struct pwm_sifive_ddata
- Rename function prefix as per driver name
- Other minor fixes based upon feedback on v3

v3
- Add a link to the reference manaul
- Use appropriate apis for division operation
- Add check for polarity
- Enable clk before calling clk_get_rate
- Other minor fixes based upon feedback on v2

V2 changed from V1:
- Remove inclusion of dt-bindings/pwm/pwm.h
- Remove artificial alignments
- Replace ioread32/iowrite32 with readl/writel
- Remove camelcase
- Change dev_info to dev_dbg for unnecessary log
- Correct typo in driver name
- Remove use of of_match_ptr macro
- Update the DT compatible strings and Add reference to a common
  versioning document

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 ++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 339 +++++++++++++++++++++
 4 files changed, 384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1
