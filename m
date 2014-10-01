From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v7 00/11] drm: add support for Atmel HLCDC Display
 Controller
Date: Wed, 1 Oct 2014 16:59:27 +0200
Message-ID: <20141001165927.4fc3ab63@bbrezillon>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Mark Yao <mark.yao@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

On Wed,  1 Oct 2014 16:52:57 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This series is being sent for several weeks now and I wonder if I shouldn't
> split it in several pieces:
> 1) the MFD driver + its DT doc
> 2) the PWM driver + its DT doc
> 3) the DRM/KMS driver + its DT doc
> 4) support for sama5d3 SoCs/boards
> 
> The first reason for doing this is that Lee already accepted the MFD part,
> and I'm pretty sure he'd like me to stop sending him each new version of this
> series.
> The second reason being that smaller series are more likely to be reviewed by
> subsystem maintainers :-).
> 
> Lee, if you still agree with this version, could you take the MTD part (other

                                                     I meant MFD ^

> drivers in this series depend on it).




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
