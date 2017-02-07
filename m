From: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 0/4] Add the Allwinner A31/A31s PWM driver
Date: Tue,  7 Feb 2017 20:50:42 +0300
Message-ID: <1486489846-662-1-git-send-email-lis8215@gmail.com>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLROMN3MJRBD4S5DCAKGQEAVTT4AY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

First of all im sorry for accidentally sent old patch,
please ignore them.

This is the second version of the sun6i PWM patchset.
 - added missing documentation changes
 - dts changes in separate patch

Thanks to Julian Calaby for tips.

--------------------------
This series of patches introduces support for Allwinner A31 PWM, which
is significantly differ from PWM founded in other Allwinner SoCs.
Patches 1/4 and 2/4 refactors existing code for easier A31 PWM integration.
Patch 3/4 adds support for A31 PWM on top of existing Allwinner PWM driver.
Patch 4/4 adds the PWM block to A31/A31s device tree.

Siarhei Volkau (4):
  ARM: pwm: sun4i: unification of register operations for support sun6i.
  ARM: pwm: sun4i: selectable prescaler table for support sun6i.
  ARM: pwm: sun6i: add support the Allwinner A31 PWM.
  ARM: dts: sun6i: Add the PWM block to the A31/A31s.

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |   3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   8 +
 drivers/pwm/pwm-sun4i.c                            | 193 ++++++++++++++++++---
 3 files changed, 176 insertions(+), 28 deletions(-)

-- 
2.4.11
