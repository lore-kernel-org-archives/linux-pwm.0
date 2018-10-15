Return-Path: <robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
Date: Mon, 15 Oct 2018 13:57:13 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: renesas: pwm-rcar: document
 R8A779{7|8}0 bindings
Message-ID: <20181015185713.GA15344@bogus>
References: <7f2ce332-a128-073a-762e-fb268780a145@cogentembedded.com>
 <20181012112114.GE30261@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012112114.GE30261@ulmo>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org

On Fri, Oct 12, 2018 at 01:21:14PM +0200, Thierry Reding wrote:
> On Mon, Oct 01, 2018 at 10:57:39PM +0300, Sergei Shtylyov wrote:
> > Document the R-Car V3{M|H} (R8A779{7|8}0) SoC in the  Renesas R-Car PWM
> > bindings. R8A77970's hardware is a generic R-Car gen3 PWM, while R8A77980
> > has an extra error injection register...
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> > This patch is against the 'for-next' branch of Thierry Reding's 'linux-pwm.git'
> > repo.
> > 
> >  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt |    2 ++
> >  1 file changed, 2 insertions(+)
> 
> Applied, thanks.

Some reason your tree isn't updated for linux-next?

Rob
