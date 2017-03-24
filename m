From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 1/4] gpio: mvebu: Add limited PWM support
Date: Fri, 24 Mar 2017 15:28:54 +0100
Message-ID: <20170324142854.GJ28518@lunn.ch>
References: <20170324141815.7252-1-ralph.sennhauser@gmail.com>
 <20170324141815.7252-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170324141815.7252-2-ralph.sennhauser@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Jason Cooper <jason@lakedaemon.net>, linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

> +	if (val < state->duty_cycle)
> +		state->period = 1;
> +	else {
> +		val -= state->duty_cycle;
> +		if (val > UINT_MAX)
> +			state->period = UINT_MAX;
> +		else if (val)
> +			state->period = val;
> +		else
> +			state->period = 1;
> +	}

Hi Ralph

The coding style guide says that if one side of an if else clause has
{}, the other side must as well, even if it is a single statement.

    Andrew
