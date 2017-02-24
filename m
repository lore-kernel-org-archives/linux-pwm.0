From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v4 0/9] Add the Allwinner A31/A31s PWM driver.
Date: Fri, 24 Feb 2017 08:41:07 +0300
Message-ID: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRB74OX7CQKGQEBYHN5LY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is the 4-th version of the sun6i PWM patchset.
Difference between v3 and v4:
 - patchset split on many small patches for easier bisect.
 - avoid unsafe macros usage.
 - some minor cleanups.

First two patches moves register access operations
from custom iomem read-modify-write operations to regmap API.

Patches from 3 to 6 makes all different things between
sun4i and sun6i PWM variants customizable.

Patch 7 introduce sun6i PWM driver itself.

Siarhei Volkau (9):
  pwm: sunxi: Use regmap API for register access.
  pwm: sunxi: Use regmap fields for bit operations.
  pwm: sunxi: Selectable prescaler table.
  pwm: sunxi: Customizable control and period register position.
  pwm: sunxi: Customizable regmap fields and enable bit mask.
  pwm: sunxi: Increase max number of pwm channels.
  pwm: sunxi: Add support the Allwinner A31 PWM.
  pwm: sunxi: Code cleanup.
  ARM: dts: sun6i: Add the PWM block to the A31/A31s.

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |   3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   8 +
 drivers/pwm/Kconfig                                |   2 +-
 drivers/pwm/pwm-sun4i.c                            | 366 +++++++++++++++++----
 4 files changed, 311 insertions(+), 68 deletions(-)

-- 
2.4.11
