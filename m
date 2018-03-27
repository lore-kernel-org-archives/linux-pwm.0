From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
Date: Tue, 27 Mar 2018 10:00:45 -0500
Message-ID: <20180327150045.biqr5ue5djru2dn7@rob-hp-laptop>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
 <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajkumar Rampelli <rrajk@nvidia.com>
Cc: mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 27, 2018 at 09:52:49AM -0500, Rob Herring wrote:
> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
> > Supply Device tree binding documentation for the NVIDIA
> > Tegra186 SoC's Tachometer Controller
> > 
> > Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
> > ---
> > 
> > V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
> >     Renamed dt property values of clock-names and reset-names to "tachometer"
> >     from "tach"
> 
> Read my prior comments on v1.

Also, I'm trying to make sense of who you Cc'ed on this. There's a ton 
of folks I know that I'm pretty sure don't care about this series. Start 
with get_maintainers.pl and add people you know need to see this series.

Rob
