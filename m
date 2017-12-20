From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] ARM: dts: r8a7740: Correct TPU register block size
Date: Wed, 20 Dec 2017 09:23:07 +0100
Message-ID: <20171220082306.zdtntqbajyy666zv@verge.net.au>
References: <1513699327-27357-1-git-send-email-geert+renesas@glider.be>
 <1513699327-27357-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513699327-27357-2-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Dec 19, 2017 at 05:02:05PM +0100, Geert Uytterhoeven wrote:
> The Timer Pulse Unit has registers that lie outside the declared
> register block.  Enlarge the register block size to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This was probably based on the old platform code, which also assumed a
> register block size of 0x100.

Reviewed-by: Simon Horman <simon.horman@netronome.com>

With reference to "User's Manual: Hardware" v2.00.
