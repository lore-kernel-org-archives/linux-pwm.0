From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH 0/3] pwm support for Broadcom iProc SoC's
Date: Tue,  1 Mar 2016 12:42:46 -0500
Message-ID: <1456854169-9788-1-git-send-email-yendapally.reddy@broadcom.com>
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
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This patchset contains the pwm support for the Broadcom's iProc SoC's.

The first patch provides the documentation details and the
second patch contains the controller support details. The third patch
contains the enable method for Northstar Plus SoC.

This patchset has been tested on NSP bcm958625HR board.
This patchset is based on v4.5.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: iproc-pwm-v1

Yendapally Reddy Dhananjaya Reddy (3):
  Documentation: dt: Add Broadcom iproc pwm controller binding
  pwm: kona: Add support for Broadcom iproc pwm controller
  ARM: dts: NSP: Add PWM Support to DT

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
 drivers/pwm/Kconfig                                |   6 +-
 drivers/pwm/pwm-bcm-kona.c                         | 183 ++++++++++++++++++---
 4 files changed, 172 insertions(+), 27 deletions(-)

-- 
2.1.0
