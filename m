From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [v3,1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Mon, 20 Jun 2016 14:24:32 -0400
Message-ID: <1092e8cd-33f0-888c-1e88-f996a262e1a9@osg.samsung.com>
References: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
 <20160617214151.GA1400@roeck-us.net> <20160618010855.GA67034@google.com>
 <5765805A.5070407@roeck-us.net>
 <3eac0aed-58ed-8376-dc29-ab374c67ebc0@osg.samsung.com>
 <20160620174455.GB40678@google.com> <20160620181020.GA46079@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160620181020.GA46079-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo <enric.balletbo-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Nematbakhsh <shawnn-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Brian,

On 06/20/2016 02:10 PM, Brian Norris wrote:
> Hi,
> 
> On Mon, Jun 20, 2016 at 10:44:55AM -0700, Brian Norris wrote:
>> On Mon, Jun 20, 2016 at 09:46:57AM -0400, Javier Martinez Canillas wrote:
>>> On 06/18/2016 01:09 PM, Guenter Roeck wrote:
>>>> On 06/17/2016 06:08 PM, Brian Norris wrote:
>>>>> How do you propose we do that? Do all of the following become EINVAL?
>>>>>
>>>
>>> Yes, I would just do that.
>>>
>>> The idea of this helper is to remove duplicated code and AFAICT what most EC
>>> drivers do is something similar to the following:
>>>
>>>         ret = cros_ec_cmd_xfer(ec, msg);
>>>         if (ret < 0)
>>> 	   	return ret;
>>>
>>>         if (msg->result != EC_RES_SUCCESS) {
>>>                 dev_dbg(ec->dev, "EC result %d\n", msg->result);
>>>                 return -EINVAL;
>>>         }
>>>
>>> So in practice what most drivers really care is if the result was successful
>>> or not, I don't see specific EC error handling in the EC drivers.  The real
>>> EC error code is still in the message anyways so drivers that do cares about
>>> the real EC error can look at msg->result instead.
> [...]
>>>>>          EC_RES_INVALID_COMMAND
>>>>
>>>>     -EOPNOTSUPP
>>>>
>>>>>          EC_RES_INVALID_PARAM
>>>>
>>>>     -EINVAL or -EBADMSG
>>>>
>>>>>          EC_RES_INVALID_VERSION
>>>>
>>>>     -EPROTO or -EBADR or -EBADE or -EBADRQC or -EPROTOOPT
>>>>
>>>>>          EC_RES_INVALID_HEADER
>>>>
>>>>     -EPROTO or -EBADR or -EBADE
>>>>
>>>> Doesn't look that bad to me. Also, the raw error could still be logged,
>>>> for example with dev_dbg().
>>>>
>>>
>>> Yes, I think that adding a dev_dbg() with the real EC error code should
>>> be enough, that's basically what drivers do since they can't propagate
>>> the EC error to higher layers anyways.
>>
>> I'll take a look at adding an error code translation table when I get a
>> chance. Hopefully that doesn't delay the others who are planning to use
>> this API shortly...
> 
> Actually, I had some second thoughts, and others brought similar
> concerns up to me:
> 
> What do we really win by doing the translation? It'll be difficult to do
> a 1:1 translation, and any time the EC adds additional error types,
> we'll have to update the translation. What's more, AFAICT, no one will
> really be looking at the translated error codes now, and will just be
> blindly passing them on. So maybe it makes more sense to just pick a
> single error code and pass that on instead. Possibly just -EPROTO (or
> nominate your favorite) for all EC error results, and if someone cares,


I think I didn't make clear in my previous email but yes, I also think
that a translate table for errors is not a good idea and that just a
single -EINVAL (or another error if is more suitable for all EC errors)
will be enough. I say -EINVAL because that's what you first mentioned
in a previous email and that's what most EC clients drivers are using.

I do believe that EC specific errors shouldn't be returned in a Linux
function though for the reasons I explained before.

> they decode msg->result in their driver, or check the dev_dbg() log?
>

And yes, I also think that a dev_dbg() is a good idea (the more data
we have about an error, the better) and as mentioned the EC error can
always be found in the EC message result field.
 
> Brian
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
