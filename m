From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 0/4] Add support for PWM Configure and stablize for PWM kona
Date: Thu, 17 Jan 2019 01:45:12 +0530
Message-ID: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
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
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi,
	This patchset contain support to make PWM changes configure
	and stablize
	Following are brief changes done
	a. Add support for version2 compatible string
	b. Change PWM config and stablize delay in PWM Kona

Changes since V1:
	- Addressed review comments

Praveen Kumar B (3):
  dt-bindings: pwm: kona: Add new compatible for new version pwm-cygnus
  drivers: pwm: pwm-bcm-kona: Add cygnus-pwm support
  ARM: dts: cygnus: Change pwm compatible to new version

Sheetal Tigadoli (1):
  drivers: pwm: pwm-bcm-kona: Switch to using atomic PWM Framework

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
 drivers/pwm/pwm-bcm-kona.c                         | 290 +++++++++++----------
 3 files changed, 158 insertions(+), 136 deletions(-)

-- 
1.9.1
