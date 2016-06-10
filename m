From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 13/13] regulator: pwm: Document pwm-dutycycle-unit and
 pwm-dutycycle-range
Date: Fri, 10 Jun 2016 09:06:20 -0500
Message-ID: <20160610140620.GA6461@rob-hp-laptop>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465403688-17098-14-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35955 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbcFJOGW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 10:06:22 -0400
Content-Disposition: inline
In-Reply-To: <1465403688-17098-14-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>

On Wed, Jun 08, 2016 at 06:34:48PM +0200, Boris Brezillon wrote:
> Document the pwm-dutycycle-unit and pwm-dutycycle-range properties.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Brian Norris <briannorris@chromium.org>
> ---
>  .../devicetree/bindings/regulator/pwm-regulator.txt   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
