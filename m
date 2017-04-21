From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
Date: Fri, 21 Apr 2017 11:19:52 +0200
Message-ID: <20170421111952.54978e80@free-electrons.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com>
 <20170412163128.5c985a26@free-electrons.com>
 <20170412151932.GE7023@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170412151932.GE7023@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Jason Cooper <jason@lakedaemon.net>, linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, Ralph Sennhauser <ralph.sennhauser@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Wed, 12 Apr 2017 17:19:32 +0200, Andrew Lunn wrote:

> Yep. It was a compromise. By adding a new binding for the GPIO driver,
> this might be possible. But it did not seem worth such a major change.
> 
> The prime use of this feature is for controlling a fan. So far, i've
> not seen any hardware with more than one fan, i.e. needs more than one
> PWM. Nor have i seen any hardware with the GPIO for the fan being on
> the third bank. A hardware manufacture could add multiple fans, but i
> doubt it, they make noise and fail. And if a manufacture does place a
> fan on the third bank, it can still be controlled as a plain GPIO fan,
> as we have been doing for the last few years.

Right.

> So i personally think it is an O.K. compromise.

I clearly don't want to block this, but I believe this is a very good
illustration of why stable DT bindings simply don't work. We are
realizing here that having each GPIO bank represented as a separate DT
node doesn't work, because this blinking functionality is not per GPIO
bank, but global to all GPIO banks.

I am totally fine with compromise, and having things simple first, and
extend them later if needed. But this stable DT binding rule makes this
quite impossible: what is a compromise today might put you in big
troubles tomorrow.

Anyway, it's fine for me, I don't think it's worth the effort making a
much more complicated solution/change.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
