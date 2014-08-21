From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v4 00/11] drm: add support for Atmel HLCDC Display
 Controller
Date: Thu, 21 Aug 2014 12:16:02 +0200
Message-ID: <53F5C6E2.7070604@samsung.com>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140821081619.GZ2452@ldesroches-Latitude-E6320>
 <20140821103706.2349915d@bbrezillon> <20140821090406.GA13733@ulmo>
 <20140821114159.319e741b@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <20140821114159.319e741b@bbrezillon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 08/21/2014 11:41 AM, Boris BREZILLON wrote:
> On Thu, 21 Aug 2014 11:04:07 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
>> On Thu, Aug 21, 2014 at 10:37:06AM +0200, Boris BREZILLON wrote:
>>> Hi Ludovic,
>>>
>>> On Thu, 21 Aug 2014 10:16:19 +0200
>>> Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
>>>
>>>> Hi Boris,
>>>>
>>>> You can add
>>>>
>>>> Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> Thanks for testing this driver.
>>>
>>>>
>>>> Only one issue but not related to your patches, you can't display
>>>> quickly the bootup logo since the panel detection takes too much
>>>> time.
>>>
>>> Yes, actually this is related to the device probe order: the
>>> hlcdc-display-controller device is probed before the simple-panel, thus
>>> nothing is detected on the RGB connector (I use of_drm_find_panel to
>>> check for panel availability) when the display controller is
>>> instantiated. I rely on the default polling infrastructure provided by
>>> the DRM/KMS framework which polls for a new connector every 10s, and
>>> this is far more than you kernel boot time.
>>>
>>> Do anyone see a solution to reduce this delay (without changing the
>>> polling interval). I thought we could add a notifier infrastructure to
>>> the DRM panel framework, but I'm not sure this is how you want things
>>> done...
>>
>> Other drivers return -EPROBE_DEFER when a panel hasn't been registered
>> yet. This will automatically take care of ordering things in a way that
>> DRM/KMS will only be initialized after the panel has been probed.
> 
> Actually I'd like to avoid doing this with a deferred probe, because,
> AFAIU, the remote endpoint is not tightly linked with the display
> controller driver (I mean the display controller can still be
> initialized without having a display connected on it).
> Moreover the atmel dev kit I'm using has an HDMI bridge connected on
> the same RGB connector and I'd like to use it in a near future.
> Returning -EPROBE_DEFER in case of several devices connected on the
> same connector implies that I'll have to wait for all the remote
> end-points to be available before my display controller could be
> instantiated.
> 
> While this could be acceptable when all drivers are statically linked
> in the kernel, it might be problematic when you're using modules,
> meaning that you won't be able to display anything on your LCD panel
> until your HDMI bridge module has been loaded.

I agree that deferring whole drm initialization due to panel not being
ready is not an optimal solution. Nice solution of this problem is with
DSI panels, DSI bus infrastructure provides callbacks for DRM encoder
which are called when DSI panel is ready. Simple panels are platform
devices so they do not have such callbacks. To solve this in a generic
way I have proposed framework for tracking interfaces[1], the series
contains also solution for the same problem with exynos display
controller[2].

Regards
Andrzej

[1]: https://lkml.org/lkml/2014/4/30/345
[2]: https://lkml.org/lkml/2014/4/30/653

> 
>> That
>> will still cause some delay before everything gets set up, but hopefully
>> less than what you're seeing now. There's also another thread where this
>> is being discussed because deferred probing is causing "unacceptable"
>> delays as well.
> 
> Could you point this thread out to me please ?
> 
> Best Regards,
> 
> Boris
> 
