From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [v3,1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Mon, 20 Jun 2016 09:46:57 -0400
Message-ID: <3eac0aed-58ed-8376-dc29-ab374c67ebc0@osg.samsung.com>
References: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
 <20160617214151.GA1400@roeck-us.net> <20160618010855.GA67034@google.com>
 <5765805A.5070407@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5765805A.5070407-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo <enric.balletbo-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Nematbakhsh <shawnn-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Guenter, Brian

On 06/18/2016 01:09 PM, Guenter Roeck wrote:
> On 06/17/2016 06:08 PM, Brian Norris wrote:
>> On Fri, Jun 17, 2016 at 02:41:51PM -0700, Guenter Roeck wrote:
>>> On Fri, Jun 17, 2016 at 12:58:12PM -0700, Brian Norris wrote:
>>>> +int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>>>> +                struct cros_ec_command *msg)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    ret = cros_ec_cmd_xfer(ec_dev, msg);
>>>> +    if (ret < 0)
>>>> +        dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
>>>> +    else if (msg->result != EC_RES_SUCCESS)
>>>> +        return -EECRESULT - msg->result;
>>>
>>> I have been wondering about the error return codes here, and if they should be
>>> converted to standard Linux error codes. For example, I just hit error -1003
>>> with a driver I am working on. This translates to EC_RES_INVALID_PARAM, or,
>>> in Linux terms, -EINVAL. I think it would be better to use standard error
>>> codes, especially since some of the errors are logged.
>>

Agreed, specially since drivers may (wrongly) propagate whatever is returned
by this function to higher layers where the ChromeOS EC firmware error codes
makes no sense. So that will be a bug and can increase the cognitive load of
getting some weird error codes in core kernel code and developers may wonder
from where those came from until finally find that a EC driver returned that.

>> How do you propose we do that? Do all of the following become EINVAL?
>>

Yes, I would just do that.

The idea of this helper is to remove duplicated code and AFAICT what most EC
drivers do is something similar to the following:

        ret = cros_ec_cmd_xfer(ec, msg);
        if (ret < 0)
	   	return ret;

        if (msg->result != EC_RES_SUCCESS) {
                dev_dbg(ec->dev, "EC result %d\n", msg->result);
                return -EINVAL;
        }

So in practice what most drivers really care is if the result was successful
or not, I don't see specific EC error handling in the EC drivers.  The real
EC error code is still in the message anyways so drivers that do cares about
the real EC error can look at msg->result instead.

>>          EC_RES_INVALID_COMMAND
> 
>     -EOPNOTSUPP
> 
>>          EC_RES_INVALID_PARAM
> 
>     -EINVAL or -EBADMSG
> 
>>          EC_RES_INVALID_VERSION
> 
>     -EPROTO or -EBADR or -EBADE or -EBADRQC or -EPROTOOPT
> 
>>          EC_RES_INVALID_HEADER
> 
>     -EPROTO or -EBADR or -EBADE
> 
> Doesn't look that bad to me. Also, the raw error could still be logged,
> for example with dev_dbg().
>

Yes, I think that adding a dev_dbg() with the real EC error code should
be enough, that's basically what drivers do since they can't propagate
the EC error to higher layers anyways.

> Guenter
> 
>>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
