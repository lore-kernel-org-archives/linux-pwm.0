From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv8 0/4] Add Freescale FTM PWM driver.
Date: Thu, 2 Jan 2014 17:57:00 +0800
Message-ID: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
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
To: thierry.reding@gmail.com, shawn.guo@linaro.org, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This patch series is the Freescale FTM PWM implementation. And there
are 8 channels most supported by the FTM PWM. This implementation is
only compatible with device tree definition.

This patch series is based on linux-next and has been tested on Vybrid
VF610 Tower board using device tree.



Changes in v8:
- Fix some issues pointed by Thierry.
- Fix the _readl/_writel of sparse check.

- And the ftm_readl()/ftm_writel() are just copied from the
  readl()/writel(), and then add the big endian check.



Changes in v7:
- Add big-endian mode support.
- Add FTM mutex lock.
- Add period time check with the current running pwm(s).
- Recode the counter clock source selecting.
- Sort some header files alphabetically, etc.

[snip] v1~v6
